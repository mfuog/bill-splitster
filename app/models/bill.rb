class Bill < ActiveRecord::Base
  belongs_to :participant

  validates :amount, presence: true
  validates :participant, presence: true
end
