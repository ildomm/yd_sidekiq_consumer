class CreateCommodityErrors < ActiveRecord::Migration
  def change
    create_table :commodity_errors do |t|
      t.integer :commodity_id
      t.string :message

      t.timestamps null: false
    end
    add_index :commodity_errors, :commodity_id
  end
end
