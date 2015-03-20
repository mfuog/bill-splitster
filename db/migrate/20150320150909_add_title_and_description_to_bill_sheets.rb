class AddTitleAndDescriptionToBillSheets < ActiveRecord::Migration
  def change
    add_column :bill_sheets, :title, :string
    add_column :bill_sheets, :description, :text
  end
end
