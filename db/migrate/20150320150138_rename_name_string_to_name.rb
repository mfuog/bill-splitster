class RenameNameStringToName < ActiveRecord::Migration
  def change
  # The name 'name_string' was due to a typo. 
  rename_column :participants, :name_string, :name
  end
end
