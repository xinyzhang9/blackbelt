class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :buyer, index: true
      t.references :seller, index: true
      t.references :product, index: true
      t.string :amount

      t.timestamps
    end
  end
end
