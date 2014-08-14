class Survey < ActiveRecord::Base
  has_many :questions
  validates :name, :presence => true, :uniqueness => true
  before_save :capital_case_name

  private

  def capital_case_name
    self.name = self.name.capitalize
  end
end
