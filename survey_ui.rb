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
    puts "0: exit"
    choice = gets.chomp
    case choice
      when '1' then create_survey
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


menu
