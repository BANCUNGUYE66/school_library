require_relative 'person'
require_relative 'student'
require_relative 'teacher'

class PeopleList
  def initialize(people)
    @people = people
  end

  def list_all_people
    puts 'List of People:'
    @people.each_with_index do |person, index|
      puts "#{index + 1}. #{person}"
    end
  end
end
