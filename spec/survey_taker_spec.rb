require 'spec_helper'

describe SurveyTaker do
  it 'belongs to responses' do
    response = Response.create(:name => "A")
    survey_taker = SurveyTaker.create(:name => "John", :response_id => response.id)
    expect(survey_taker.response).to eq response
  end
end
