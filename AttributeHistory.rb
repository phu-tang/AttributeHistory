module AttributeHistory
  @history_bundle

  def init_method
    instance_variables.each do |var|
      define_was_method(var.to_s)
      define_changed_method(var.to_s)
      define_setter(var.to_s)
    end
  end

  def init_data
    @history_bundle = Hash.new
  end

  # define var_was method return the last value of variable
  def define_was_method(var)
    temp = var.to_s + "_was"
    temp = temp.delete("@");
    self.class.send(:define_method, temp.to_s) do
        return @history_bundle[var.to_s]
    end
  end

  #define var_changed return this variable is changed or not
  def define_changed_method(var)
    temp = var.to_s + "_changed"
    temp = temp.delete("@");
    self.class.send(:define_method, temp.to_s) do
        return(@history_bundle.has_key?(var.to_s))
    end
  end

  #define setter method
  def define_setter(var)
    temp = var.delete("@");
    self.class.send(:define_method, "#{temp}=".to_sym) do |value|
      if (value != instance_variable_get(var.to_s))
        @history_bundle[var.to_s]= instance_variable_get(var.to_s)
        instance_variable_set(var.to_s, value)
      end
    end
  end

  private :define_setter, :define_changed_method, :define_was_method
end
