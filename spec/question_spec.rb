require 'spec_helper'

  describe "Question" do
    it "has a name" do
      question = Question.new(:question => "How are you?")
      expect(question.question).to eq "How are you?"
  end

  it "validates presence of question" do
    question = Question.new({:question => ''})
    expect(question.save).to eq false
  end

  it "has many survey takers through responses" do
    question = Question.create(:question => "How are you?")
    response = Response.create(:name => "Good", :question_id => question.id)
    survey_taker = SurveyTaker.create(:name => "Bill", :response_id => response.id)
    expect(question.survey_takers).to eq [survey_taker]
  end

end
