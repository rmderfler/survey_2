class Response < ActiveRecord::Base
  belongs_to :question
  validates :name, :presence => true
  has_many :survey_takers
end
