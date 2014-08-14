class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :responses
  has_many :survey_takers, :through => :responses
  validates :question, :presence => true

end
