class Participant < ActiveRecord::Base
  belongs_to :bill_sheet, inverse_of: :participants
  has_many :owed_transactions, dependent: :destroy, class_name: "Transaction", foreign_key: "sender_id"
  has_many :receivable_transactions, dependent: :destroy, class_name: "Transaction", foreign_key: "target_id"
  has_many :bills, dependent: :destroy, inverse_of: :participant
  accepts_nested_attributes_for :bills,
                                reject_if: :reject_bills,
                                allow_destroy: true
  validates_presence_of :name
  validates_presence_of :bill_sheet

  # Determine the participant's total contribution to the
  # bill sheet by summing up all bills.
  #
  # Returns the participant's contribution as a float.
  def contribution
    bills.to_a.sum(&:amount)
  end

  # Determine the participant's total debt to the bill sheet
  # by calculating equal shares of the total expenses and dividing
  # it among participants.
  # 
  # Returns the participant's debt as a float. 
  def debt
    target_contribution = bill_sheet.total_expenses/bill_sheet.participants.size
    target_contribution - contribution    
  end

  private
    def reject_bills(attributed)
      attributed['amount'].blank?
    end
end
