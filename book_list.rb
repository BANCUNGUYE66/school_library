require_relative 'book'

class BookList
  def initialize(books)
    @books = books
  end

  def list_all_books
    puts 'List of Books:'
    @books.each_with_index do |book, index|
      puts "#{index + 1}. Title: \"#{book.title}\", Author: \"#{book.author}\""
    end
  end
end
