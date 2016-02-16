module AttributeHistory
  @history_bundle

  def init_method
    instance_variables.each do |var|
      puts (var.to_s.delete("@"))
      temp = var.to_s + "_was"
      temp = temp.delete("@");

      # define var_was method return the last value of variable
      self.class.send(:define_method, temp.to_s) do
        if @history_bundle.empty?
          return nil
        else
          return @history_bundle[var.to_s]
        end
      end

      #define var_changed return this variable is changed or not
      temp = var.to_s + "_changed"
      temp = temp.delete("@");
      self.class.send(:define_method, temp.to_s) do
        if @history_bundle.empty?
          return false
        else
          return(@history_bundle.has_key?(var.to_s))
        end
      end

      #define setter method
      temp = var.to_s
      temp = temp.delete("@");
      self.class.send(:define_method, "#{temp}=".to_sym) do |value|
        if (value != instance_variable_get(var.to_s))
          @history_bundle[var.to_s]= instance_variable_get(var.to_s)
          instance_variable_set(var.to_s, value)
        end
      end
    end
  end

  def initData
    @history_bundle = Hash.new
  end

  def get_all_vars
    instance_variables.each do |var|
      puts (var.to_s.delete("@"))
    end
  end
end
