class BillSheet < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  enum status: [:open, :closed]

  validates :creator, presence: true
  validates :status, presence: true
end
