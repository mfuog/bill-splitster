class Participant < ActiveRecord::Base
  belongs_to :bill_sheet
  validates :name, presence: true
end
