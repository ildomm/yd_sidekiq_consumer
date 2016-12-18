class CommodityHistory < ActiveRecord::Base
  belongs_to :commodity

  UPDATE_TYPE = [SEQUENCE = 1, UNIQUE = 2]

  def self.last_update( update_type )
    history = CommodityHistory
                  .where( update_type: update_type )
                  .order(:updated_at).last
    history ? history.updated_at : nil
  end

  def self.last_trade_price( commodity, update_type )
    history = CommodityHistory.where( commodity: commodity, update_type: update_type )
                  .order(:updated_at).last
    history ? history.last_trade_price : nil
  end

  def self.last_entries( update_type )
    history = CommodityHistory
                  .where( "updated_at >= ? AND update_type = ? ", Time.now - 1.hour, update_type )
                  .order(updated_at: :desc).all
    history ? history : []
  end

end
