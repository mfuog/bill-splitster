class Transaction < ActiveRecord::Base
  belongs_to :sender, class_name: "Participant", foreign_key: "sender_id"
  belongs_to :target, class_name: "Participant", foreign_key: "target_id"

  validates_presence_of :amount
end
