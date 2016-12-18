class CommodityError < ActiveRecord::Base
  belongs_to :commodity

  def self.last_errors(limit)
    errors = self.order(updated_at: :desc).limit(limit)
    errors ? errors : []
  end
end
