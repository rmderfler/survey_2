require 'active_record'
require './lib/survey'
require './lib/question'
require './lib/response'
require './lib/survey_taker'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def menu
  puts "Welcome to S & M Quiz!"
  choice = nil
  until choice == '0'
    puts "1: create a survey"
    puts "2: list surveys"
    puts "3: add responses"
    puts "4: create a question"
    puts "5: take a survey"
    puts "6: count answers"
    puts "0: exit"
    choice = gets.chomp
    case choice
      when '1' then create_survey
      when '2' then list_surveys
      when '3' then add_response
      when '4' then create_question
      when '5' then take_survey
      when '6' then count_answers
      when '0' then exit
      else
        puts "This is not a valid option"
    end
  end
end

def create_survey
  print "Name your survey: "; survey_name = gets.chomp
  new_survey = Survey.create(:name => survey_name)
  if new_survey.save
    puts "'#{survey_name}' has been added."
  else
    puts "That wasn't a valid option."
  end
end

def list_surveys
  puts "Here all the surveys:"
  Survey.all.each_with_index {|survey, i| puts "#{i + 1}. #{survey.name}"}
  puts "\n\n"
end

def add_response
  list_surveys
  print "Choose a survey: "; selected_survey = gets.chomp
  survey = Survey.all[((selected_survey).to_i)-1]
  puts "\n\n"
  puts "Here are all the questions from the #{survey.name} survey:"
  survey.questions.each_with_index do |question, i|
    puts "#{i + 1}. #{question.question}"
  end
  print "Choose a question to add a response to: "; question = gets.chomp
  question = survey.questions[((question).to_i)-1]

  4.times do
    print "Add a new response to #{question.question}: "; name = gets.chomp
    new_response = Response.create(:name => name, :question_id => question.id)
    puts "New response was added"
  end
end

def create_question
  print "Write a question: "; question = gets.chomp
  list_surveys
  print "Add the question to a survey: "; selected_survey = gets.chomp
  survey_id = Survey.find_by(:name => selected_survey).id
  new_question = Question.create(:question => question, :survey_id => survey_id)
  if new_question.save
    puts "'#{question}' has been added."
  else
    puts "That wasn't a valid option."
  end
end


def take_survey
  list_surveys
  p "what is your name?"; name = gets.chomp
  p "Which survey would you like to take?"; selected_survey = gets.chomp
  survey = Survey.find_by(:name => selected_survey)
  survey.questions.each do |question|
    puts "#{question.question}\n"
    question.responses.each_with_index do |response, x|
      puts "#{x + 1}. #{response.name}\n"
    end
    input = gets.chomp
    if (input.to_i.to_s == input) == true
      answer = question.responses[((input).to_i)-1]
      SurveyTaker.create(:name => name, :response_id => answer.id)
      puts "answer received"
      4.times do
        print "Do you wanna make one more choice?"; user_input = gets.chomp
        if user_input == 'y'
          print "Choose an answer"; input = gets.chomp
          answer = question.responses[((input).to_i)-1]
          SurveyTaker.create(:name => name, :response_id => answer.id)
        elsif user_input == 'n'
          break
        end
      end
    else
      new_response = Response.create(:name => input, :question_id => question.id)
      SurveyTaker.create(:name => name, :response_id => new_response.id)
    end
  end
end


def count_answers
  list_surveys
  p "Choose a survey"; selected_survey = gets.chomp
  survey = Survey.find_by(:name => selected_survey)
  survey.questions.each { |question| puts "#{question.question}" }
  puts "choose a question"; selected_question = gets.chomp
  question = Question.find_by(:question => selected_question )
  question.responses.each { |response| puts "#{response.name}" }
  puts "choose a response"; selected_response = gets.chomp
  response = Response.find_by(:name => selected_response)
  chose_that_response = response.survey_takers.length
  puts chose_that_response.to_s
end



menu
