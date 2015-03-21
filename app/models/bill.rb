class Bill < ActiveRecord::Base
  belongs_to :participant, inverse_of: :bills

  validates_presence_of :participant
  validates_presence_of :amount
end
