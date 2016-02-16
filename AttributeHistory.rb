module AttributeHistory

  def init_method
    instance_variables.each do |var|
      puts (var.to_s.delete("@"))
      temp = var.to_s + "_was"
      temp = temp.delete("@");

      self.class.send(:define_method, temp.to_s) do
        return "hello"
      end
    end

  end

  def get_all_vars
     instance_variables.each do |var|
      puts (var.to_s.delete("@"))
    end
  end
end
