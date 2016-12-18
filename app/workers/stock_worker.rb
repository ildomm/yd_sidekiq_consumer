class StockWorker
  include Sidekiq::Worker
  sidekiq_options unique: true

  def perform( update_type )
    @yahoo_client = YahooFinance::Client.new
    @update_type  = update_type

    commodities = get_commodities
    commodities.each{ |commodity|
      update_quote(commodity)
    }
  end

  def get_commodities
    Commodity.all
  end

  def update_quote(commodity)
    begin
      data = @yahoo_client.quotes([commodity.name],
                                  [:last_trade_price, :last_trade_date, :change, :previous_close])

      return persist_error( commodity, 'no data' ) if data.nil?

      if data[0][:last_trade_price].numeric?
        persist_quote( commodity, fix_date( data[0].to_h ) )
      else
        persist_error( commodity, data[0][:last_trade_price] )
      end

    rescue Exception => e
      persist_error( commodity, e.message )
    end
  end

  def fix_date( data )
    data[:last_trade_date] = Date.strptime(data[:last_trade_date], "%m/%d/%Y")
    return data
  end

  def persist_quote( commodity, data )
    if update_allowed?( commodity, data )
      data[:commodity]   = commodity
      data[:update_type] = @update_type
      CommodityHistory.create( data )
    end
  end

  def update_allowed?( commodity, data )
    if @update_type == CommodityHistory::UNIQUE
      # Necessary to check last entry
      last_trade_price = CommodityHistory.last_trade_price( commodity, @update_type )

      # Allowed only new prices
      if data[:last_trade_price].to_f == last_trade_price
        return false
      else
        return true
      end
    else
      return true
    end
  end

  def persist_error( commodity, message )
    CommodityError.create( { :commodity => commodity , :message => message } )
  end

end