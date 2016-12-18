class Commodity < ActiveRecord::Base
  validates_presence_of :name

  has_many :commodity_histories
  has_many :commodity_errors

  def last_trade_date
    history = self.commodity_histories.order(:updated_at).last
    history ? history.last_trade_date : nil
  end

  def last_update
    history = self.commodity_histories.order(:updated_at).last
    history ? history.updated_at : history = self.commodity_errors.order(:updated_at).last
    history ? history.updated_at : nil
  end

  def last_trade_price
    history = self.commodity_histories.order(:updated_at).last
    history ? history.last_trade_price : nil
  end

  def last_trades(limit)
    history = self.commodity_histories.order(updated_at: :desc).limit(limit)
    history ? history : []
  end

end
