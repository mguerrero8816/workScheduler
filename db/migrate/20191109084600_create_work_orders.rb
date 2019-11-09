class CreateWorkOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :work_orders do |t|
      t.references :technician, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true
      t.datetime :time
      t.integer :duration
      t.integer :price
    end
  end
end
