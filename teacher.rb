require_relative 'person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(name = 'Unknown', age = nil, specialization = '', parent_permission: true)
    super(name, age)
    @specialization = specialization
    @parent_permission = parent_permission
  end

  def can_use_services?
    true
  end

  def to_json(*args)
    {
      'name' => @name,
      'age' => @age,
      'parent_permission' => @parent_permission,
      'type' => 'teacher',
      'specialization' => @specialization
    }.to_json(*args)
  end
end
