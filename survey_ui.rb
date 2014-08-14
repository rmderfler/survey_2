require 'active_record'
require './lib/survey'
require './lib/question'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def menu
  puts "Welcome to S & M Quiz!"
  choice = nil
  until choice == '0'
    puts "1: create a survey"
    puts "2: list surveys"
    puts "4: create a question"
    puts "0: exit"
    choice = gets.chomp
    case choice
      when '1' then create_survey
      when '2' then list_surveys
      when '4' then create_question
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

def create_question
  print "Write a question: "; question = gets.chomp
  list_surveys
  print "Add the question to a survey: "; selected_survey = gets.chomp
  survey_id = Survey.find_by(:name => selected_survey).id
  new_question = Question.new(:question => question, :survey_id => survey_id)
  if new_question.save
    puts "'#{question}' has been added."
  else
    puts "That wasn't a valid option."
  end
end


menu
