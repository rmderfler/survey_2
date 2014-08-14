require 'spec_helper'

describe Survey do
  it "validates presence of name" do
    survey = Survey.new({:name => ''})
    expect(survey.save).to eq false
  end
end
