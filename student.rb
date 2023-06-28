require_relative 'person'

class Student < Person
  attr_accessor :parent_permission

  def initialize(name = 'Unknown', age = nil, parent_permission: true)
    super(name, age)
    @parent_permission = parent_permission
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def to_json(*args)
    {
      'name' => @name,
      'age' => @age,
      'parent_permission' => @parent_permission,
      'type' => 'student'
    }.to_json(*args)
  end
end
