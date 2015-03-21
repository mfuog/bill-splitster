class Participant < ActiveRecord::Base
  belongs_to :bill_sheet, inverse_of: :participants
  has_many :bills, dependent: :destroy

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
end
