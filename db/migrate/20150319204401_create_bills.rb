class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.float :amount
      t.string :title
      t.text :note
      t.references :participant, index: true

      t.timestamps null: false
    end
    add_foreign_key :bills, :participants
  end
end
