require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def run
    loop do
      display_menu
      choice = gets.chomp.to_i
      process_choice(choice)
      break if choice == 7
    end
    puts 'Thank you for using this app. Goodbye!'
  end

  def display_menu
    puts 'Please choose an option:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List all rentals for a given person ID'
    puts '7. Quit'
  end

  def process_choice(choice)
    case choice
    when 1
      list_books
    when 2
      list_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals_by_person_id
    else
      puts 'Invalid choice. Please try again.'
    end
  end

  def list_books
    puts 'List of all books:'
    books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    puts 'List of all people:'
    people.each do |person|
      puts "ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
    end
  end

  def create_person
    puts "Enter the person's name:"
    name = gets.chomp

    puts "Enter the person's age:"
    age = gets.chomp.to_i

    puts 'Is parent permission granted? (Y/N)'
    parent_permission = gets.chomp.upcase == 'Y'

    puts 'Is the person a student or teacher? (S/T)'
    person_type = gets.chomp.upcase

    case person_type
    when 'S'
      create_student(name, age, parent_permission)
    when 'T'
      create_teacher(name, age, parent_permission)
    else
      puts 'Invalid person type.'
    end
  end

  def create_student(name, age, parent_permission)
    puts "Enter the student's classroom:"
    classroom = gets.chomp

    student = Student.new(classroom, name, age, parent_permission: parent_permission)
    people << student
    puts "Student created with ID: #{student.id}"
  end

  def create_teacher(name, age, parent_permission)
    puts "Enter the teacher's specialization:"
    specialization = gets.chomp

    teacher = Teacher.new(specialization, name, age, parent_permission: parent_permission)
    people << teacher
    puts "Teacher created with ID: #{teacher.id}"
  end

  def create_book
    puts "Enter the book's title:"
    title = gets.chomp

    puts "Enter the book's author:"
    author = gets.chomp

    book = Book.new(title, author)
    books << book
    puts "Book created with title: #{book.title}"
  end

  def create_rental
    puts 'Enter the rental date (YYYY-MM-DD):'
    date = gets.chomp

    puts 'Enter the person ID for the rental:'
    person_id = gets.chomp.to_i

    person = find_person_by_id(person_id)
    return if person.nil?

    puts 'Enter the book title for the rental:'
    book_title = gets.chomp

    book = find_book_by_title(book_title)
    return if book.nil?

    rental = Rental.new(date, book, person)
    rentals << rental
    puts "Rental created for person ID #{person.id} and book title #{book.title}"
  end

  def find_person_by_id(person_id)
    person = people.find { |p| p.id == person_id }
    if person.nil?
      puts "Person with ID #{person_id} not found."
      return nil
    end
    person
  end

  def find_book_by_title(book_title)
    book = books.find { |b| b.title == book_title }
    if book.nil?
      puts "Book with title #{book_title} not found."
      return nil
    end
    book
  end

  def list_rentals_by_person_id
    puts 'Enter the person ID to list rentals:'
    person_id = gets.chomp.to_i

    person = find_person_by_id(person_id)
    return if person.nil?

    puts "List of rentals for person ID #{person.id}:"
    rentals_by_person = rentals.select { |r| r.person == person }
    rentals_by_person.each do |rental|
      puts "Rental Date: #{rental.date}, Book Title: #{rental.book.title}"
    end
  end
end
