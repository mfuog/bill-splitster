class BillSheet < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  has_many :participants, dependent: :destroy, inverse_of: :bill_sheet
  accepts_nested_attributes_for :participants,
                                reject_if: :reject_participants,
                                allow_destroy: true
  enum status: [:open, :closed]
  before_validation :default_values

  validates_presence_of :title
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

  def update_transactions
    # destroy won't delete models without an id key
    participants.flat_map { |p| p.transactions_incoming.delete_all }
    participants.flat_map { |p| p.transactions_outgoing.delete_all }
    create_transactions
  end

  private
    def default_values
      self.status ||= "open"
    end

    def create_transactions
      participants.each do |p|
        share = p.contribution/participants.size
        participants.each do |p2|
          unless p2 == p || share == 0.0
            # If a transaction between both participants exists,
            # only update the amount accordingly
            t = Transaction.where(sender: p, target: p2).first
            if t && [t.amount, share].max == t.amount
              t.update!(amount: t.amount - share)
            else
              Transaction.create(amount: share, sender: p2, target: p)
            end
          end
        end
      end    
    end

    def reject_participants(attributed)
      attributed['name'].blank?
    end
end
