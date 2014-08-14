require 'active_record'
require './lib/survey'
require './lib/question'
require './lib/response'

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
    puts "0: exit"
    choice = gets.chomp
    case choice
      when '1' then create_survey
      when '2' then list_surveys
      when '3' then add_response
      when '4' then create_question
      when '5' then take_survey
      when '0' then exit
      else
        puts "This is not a valid option"
    end
  end
end

def create_survey
  print "Name your survey: "; survey_name = gets.chomp
  new_survey = Survey.new(:name => survey_name)
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
  survey = Survey.find_by(:name => selected_survey)
  puts "\n\n"
  puts "Here are all the questions from the #{survey.name} survey:"
  survey.questions.each_with_index do |question, i|
    puts "#{i + 1}. #{question.question}"
  end
  print "Choose a question to add a response to: "; question = gets.chomp
  question_id = Question.find_by(:question => question).id
  print "Add a new response to the question: "; name = gets.chomp
  new_response = Response.create(:name => name, :question_id => question_id)
  puts "New response was added"
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
  p "Which survey would you like to take?"; selected_survey = gets.chomp

  survey = Survey.find_by(:name => selected_survey)
  survey.questions.each_with_index do |question, i|
    puts "#{i +1}.  #{question.question}\n"
    question.responses.each_with_index do |response, x|
      puts "Possible answers:"
      puts "#{x + 1}. #{response.name}\n"

    end
    answer = gets.chomp
    puts "answer received"
  end
end

menu
