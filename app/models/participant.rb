class Participant < ActiveRecord::Base
  belongs_to :bill_sheet
  has_many :bills, dependent: :destroy
  validates :name, presence: true
  validates :bill_sheet_id, presence: true

  # Determine the participant's current contribution to the bill sheet
  # by summing up all bills.
  #
  # Returns the participant's total contribution as a float.
  def total_contribution
    sum = 0.0
    bills.each do |bill|
      sum += bill.amount
    end
    sum
  end
end
