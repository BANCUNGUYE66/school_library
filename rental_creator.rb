require_relative 'person'
require_relative 'student'
require_relative 'teacher'

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
end
