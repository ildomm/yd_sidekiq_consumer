class HistoryController < ApplicationController

  def sequence
    get_last_sequence_info
  end
  def sequence_refresh
    get_last_sequence_info
    render :partial => "history/sequence"
  end

  def unique
    get_last_unique_info
  end
  def unique_refresh
    get_last_unique_info
    render :partial => "history/unique"
  end

  private

    def get_last_sequence_info
      @last_update = CommodityHistory.last_update( CommodityHistory::SEQUENCE )
      @commodities = Commodity.all
      @errors      = CommodityError.last_errors(50)
    end

    def get_last_unique_info
      @last_update = CommodityHistory.last_update( CommodityHistory::UNIQUE )
      @commodity_histories = CommodityHistory.last_entries( CommodityHistory::UNIQUE )
    end

end
