class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :responses
  validates :question, :presence => true
end
