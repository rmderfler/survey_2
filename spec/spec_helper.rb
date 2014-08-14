require 'active_record'
require 'rspec'
require 'survey'
require 'question'
require 'response'
require 'survey_taker'
require 'pry'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each { |survey| survey.destroy }
    Question.all.each { |question| question.destroy }
    Response.all.each { |response| response.destroy }
    Survey.all.each { |survey| survey.destroy }
  end
end
