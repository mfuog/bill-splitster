class CreateTransaction < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.float :amount
      t.references :sender, references: :participants, index: true
      t.references :target, references: :participants, index: true

      t.timestamps
    end
    add_index :transactions, [:sender_id, :target_id], unique: true
  end
end
