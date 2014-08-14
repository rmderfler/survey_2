class Question < ActiveRecord::Base
  belongs_to :survey
  validates :question, :presence => true
end
