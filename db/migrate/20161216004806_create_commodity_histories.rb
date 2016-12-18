class CreateCommodityHistories < ActiveRecord::Migration
  def change
    create_table :commodity_histories do |t|
      t.integer :commodity_id
      t.float :last_trade_price
      t.date :last_trade_date
      t.float :change
      t.float :previous_close

      #[sequence, unique]
      t.integer :update_type

      t.timestamps null: false
    end
    add_index :commodity_histories, :commodity_id
    add_index :commodity_histories, :update_type
  end
end
