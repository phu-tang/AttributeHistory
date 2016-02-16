module AttributeHistory

  instance_variables.each do |variable|
    define_method ("was_#{variable}") do
      return variable
    end
  end


  def get_all_vars
    return instance_variables
  end
end
