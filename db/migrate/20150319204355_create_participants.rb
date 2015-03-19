class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :name_string
      t.float :balance
      t.references :bill_sheet, index: true

      t.timestamps null: false
    end
    add_foreign_key :participants, :bill_sheets
  end
end
