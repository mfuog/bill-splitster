class Participant < ActiveRecord::Base
  belongs_to :bill_sheet, inverse_of: :participants
  has_many :bills, dependent: :destroy, inverse_of: :participant
  accepts_nested_attributes_for :bills,
                                reject_if: :reject_bills,
                                allow_destroy: true
  validates_presence_of :name
  validates_presence_of :bill_sheet

  # Determine the participant's current contribution to the bill sheet
  # by summing up all bills.
  #
  # Returns the participant's total contribution as a float.
  def total_contribution
    sum = 0.0
    bills.each do |bill|
      sum += bill.amount unless bill.new_record?
    end
    sum
  end

  def reject_bills(attributed)
    attributed['amount'].blank?
  end
end
