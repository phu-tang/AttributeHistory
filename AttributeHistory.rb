module AttributeHistory
  @history_bundle

  def self.included(base)

  end

  def method_missing(method_id, *arguments, &block)

    #define setter method
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

    # define var_was method return the last value of variable
    if (method_id.to_s.end_with?("_was"))
      name = method_id.to_s.sub("_was", "")
      name = "@" + name
      if (content_variable?(name))
        return get_history_bundle[name]
      else
        super
      end
    end

    #define var_changed return this variable is changed or not
    if (method_id.to_s.end_with?("_changed?"))
      name = method_id.to_s.sub("_changed?", "")
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

  def get_history_bundle
    if (@history_bundle.nil?)
      @history_bundle = Hash.new
    end
    return @history_bundle
  end

  private :content_variable?, :get_history_bundle
end
