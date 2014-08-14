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

end
