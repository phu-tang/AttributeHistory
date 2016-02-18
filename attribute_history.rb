module AttributeHistory
  @history_bundle

  @@attributes =[]

  def self.included base
    def base.attr *args
      @@attributes.concat(args)
      args.each do |attribute|
        self.send(:attr_reader, attribute)
      end
    end
  end

  def method_missing(method_id, *arguments, &block)
    #define setter method
    if (method_id.to_s.end_with?("="))
      name = method_id.to_s.delete("=")
      if (content_variable?(name))
        name = "@" + name
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
      if (content_variable?(name))
        name = "@" + name
        return get_history_bundle[name]
      else
        super
      end
    end

    #define var_changed return this variable is changed or not
    if (method_id.to_s.end_with?("_changed?"))
      name = method_id.to_s.sub("_changed?", "")
      if (content_variable?(name))
        name = "@" + name
        return(get_history_bundle.has_key?(name))
      else
        super
      end
    end

    super
  end

  def content_variable? (name)
    @@attributes.each do |var|
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
