module AttributeHistory
  @history_bundle

  def self.included(base)

  end

  def method_missing(method_id, *arguments, &block)
    if (method_id.to_s.end_with?("="))
      name = method_id.to_s.delete("=")
      name = "@" + name
      if (content_variable?(name))
        get_history_bundle[name]= instance_variable_get(name)
        instance_variable_set(name.to_s, arguments.at(0))
        return
      else
        super
      end
    end

    if(method_id.to_s.end_with?("_was"))
      name = method_id.to_s.sub("_was","")
      name = "@" + name
      if (content_variable?(name))
        return get_history_bundle[name]
      else
        super
      end
    end

    if(method_id.to_s.end_with?("_changed?"))
      name = method_id.to_s.sub("_changed?","")
      name = "@" + name
      if (content_variable?(name))
        return(get_history_bundle.has_key?(name))
      else
        super
      end
    end
    super
  end

  def content_variable? (name)
    instance_variables.each do |var|
      if (var.to_s == name)
        return true
      end
    end
    return false
  end

  def init_method
    instance_variables.each do |var|
      define_was_method(var.to_s)
      define_changed_method(var.to_s)
      define_setter(var.to_s)
    end
  end

  def get_history_bundle
    if (@history_bundle.nil?)
      @history_bundle = Hash.new
    end
    return @history_bundle
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
