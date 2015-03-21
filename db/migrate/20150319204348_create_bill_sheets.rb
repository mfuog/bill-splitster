class CreateBillSheets < ActiveRecord::Migration
  def change
    create_table :bill_sheets do |t|
      t.integer :status
      t.references :creator, references: :users, index: true

      t.timestamps null: false
    end
    #add_foreign_key :bill_sheets, :users
  end
end
