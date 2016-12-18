class CreateCommodities < ActiveRecord::Migration
  def change
    create_table :commodities do |t|
      t.string :name

      t.timestamps null: false
    end
    add_index :commodities, :name
  end
end
