require_relative 'nameable'

class Person < Nameable
  attr_accessor :id, :name, :age, :rentals

  def initialize(name = 'Unknown', age = nil, parent_permission: true)
    super()
    @id = generate_id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(date, book)
    rental = Rental.new(date, book, self)
    rentals << rental
  end

  private

  def of_age?
    @age && @age >= 18
  end

  def generate_id
    rand(1..1000)
  end

  def to_json(*_args)
    {
      'name' => name,
      'age' => age,
      'parent_permission' => parent_permission?,
      'type' => self.class.name,
      'id' => id,
      'rentals' => rentals.map(&:to_json)
    }

    def to_s
      "Name: #{@name}, Age: #{@age}, Parent Permission: #{@parent_permission}, Type: #{self.class}, ID: #{@id}"
    end
  end
end
