require 'spec_helper'

describe Survey do

  it "validates presence of name" do
    survey = Survey.new({:name => ''})
    expect(survey.save).to eq false
  end

  it "requires a unique survey name" do
    survey = Survey.new({:name => 'A'}).save
    survey2 = Survey.new({:name => 'A'})
    expect(survey2.save).to eq false
  end

  it "capitalizes the name" do
    survey = Survey.new(:name => 'apple')
    survey.save
    expect(survey.name).to eq "Apple"
  end
end
