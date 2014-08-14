require 'spec_helper'

describe "Response" do
  it "belongs to a question" do
    question = Question.create(:question => "How are you?")
    response = Response.create(:name => "Good", :question_id => question.id)
    expect(response.question).to eq question
  end
end
