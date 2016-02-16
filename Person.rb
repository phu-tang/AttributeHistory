require './AttributeHistory'
class Person
  include AttributeHistory
  attr :name, :dob

  def initialize(name, dob)
    @name = name
    @dob = dob
    init_method
  end

end


a = Person.new("a","b")
puts a.name
puts a.dob
a.get_all_vars
a.name_was
