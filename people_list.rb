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
      person_type = person.is_a?(Student) ? 'Student' : 'Teacher'
      puts "#{index + 1}. [#{person_type}]  Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end
end
