require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require 'json'

class PersonCreator
  def initialize(people)
    @people = people
  end

  def create_person
    puts 'Do you want to create a student(1) or a teacher (2)? [Input the number]:'
    person_type = gets.chomp.to_i

    puts 'Age:'
    age = gets.chomp.to_i

    puts 'Name:'
    name = gets.chomp

    case person_type
    when 1
      create_student(name, age)
    when 2
      create_teacher(name, age)
    else
      puts 'Invalid person type.'
      return
    end

    save_people_to_file # Save the updated people list to "people.json"

    puts 'Person created successfully.'
  end

  private

  def create_student(name, age)
    puts 'Has parent permission? [Y/N]:'
    parent_permission = gets.chomp.downcase == 'y'

    student = Student.new(name, age, parent_permission: parent_permission)
    @people << student
  end

  def create_teacher(name, age)
    puts 'Specialization:'
    specialization = gets.chomp

    teacher = Teacher.new(name, age, specialization)
    @people << teacher
  end

  def save_people_to_file
    people_data = @people.map do |person|
      data = {
        'name' => person.name,
        'age' => person.age,
        'type' => person.class.name,
        'id' => person.id
      }
      data['parent_permission'] = person.parent_permission if person.is_a?(Student)
      data['specialization'] = person.specialization if person.is_a?(Teacher)
      data
    end

    File.write('people.json', JSON.pretty_generate(people_data))
  end
end
