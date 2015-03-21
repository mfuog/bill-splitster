class RemoveBalanceFromParticipants < ActiveRecord::Migration
  def change
    remove_column :participants, :balance, :float
  end
end
