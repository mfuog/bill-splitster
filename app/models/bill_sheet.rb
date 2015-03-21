class BillSheet < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  has_many :participants, dependent: :destroy, inverse_of: :bill_sheet
  accepts_nested_attributes_for :participants,
                                reject_if: :reject_participants,
                                allow_destroy: true
  enum status: [:open, :closed]

  validates_presence_of :creator
  validates_presence_of :status

  # Determine the total amount of money spent by all participants of
  # the bill sheet.
  #
  # Return the the total amount of expenses as a float.
  def total_expenses
    sum = 0.0
    participants.each do |p|
      sum += p.contribution
    end
    sum
  end

  def reject_participants(attributed)
    attributed['name'].blank?
  end
end
