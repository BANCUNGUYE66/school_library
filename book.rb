class Book
  attr_accessor :title, :author, :rentals
  attr_reader :id

  @id_counter = 0

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
    @id = generate_id
  end

  class << self
    attr_reader :id_counter
  end

  def self.increment_id_counter
    @id_counter += 1
  end

  def generate_id
    self.class.increment_id_counter
  end

  def to_json(*_args)
    {
      'title' => title,
      'author' => author,
      'id' => id
    }.to_json
  end
end
