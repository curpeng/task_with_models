class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :item_id
      t.integer :order_id

      t.timestamps
    end
  end
end
