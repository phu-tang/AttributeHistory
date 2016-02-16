require './AttributeHistory'
class Person
  include AttributeHistory
  attr :name, :dob
  def initialize(name, dob)
    @name = name
    @dob = dob
  end

end

a = Person.new("Phu","1/1/2016")
puts a.name
puts a.dob
puts a.get_all_vars
put a.was_name
