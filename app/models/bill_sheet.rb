class BillSheet < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
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
  # Returns the the total amount of expenses as a float.
  def total_expenses
    bills.sum(&:amount)
  end

  # Determine the bills of all participants of the bill sheet.
  # 
  # Returns all bills within the bill sheet.
  def bills
    participants.flat_map { |p| p.bills }
  end


  def create_transactions
    Transaction.destroy_all
    participants.each do |p|
      share = p.contribution/participants.size
      participants.each do |p2|
        unless p2 == p
          Transaction.create(amount: share, sender: p2, target: p)
        end
      end
    end
  end

  private
    def reject_participants(attributed)
      attributed['name'].blank?
    end
end
