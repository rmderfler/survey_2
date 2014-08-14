require 'spec_helper'

describe "Response" do
  it "belongs to a question" do
    question = Question.create(:question => "How are you?")
    response = Response.create(:name => "Good", :question_id => question.id)
    expect(response.question).to eq question
  end

  it "has many 'survey takers'" do
    question = Question.create(:question => "How are you?")
    response = Response.create(:name => "Good", :question_id => question.id)
    survey_taker = SurveyTaker.create(:name => "Bill", :response_id => response.id)
    expect(response.survey_takers).to eq [survey_taker]
  end

  it "tells us how many people answered" do
    question = Question.create(:question => "How are you?")
    response = Response.create(:name => "Good", :question_id => question.id)
    response2 = Response.create(:name => "Bad", :question_id => question.id)
    survey_taker = SurveyTaker.create(:name => "Bill", :response_id => response2.id)
    survey_taker = SurveyTaker.create(:name => "Bob", :response_id => response.id)
    expect(response.survey_takers.length).to eq 1
  end
end
