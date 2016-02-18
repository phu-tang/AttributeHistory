require 'nokogiri'


module HtmlParser
  @html_content
  @@attributes =[]

  def self.included base
    def base.attr *args
      @@attributes.concat(args)
      args.each do |attribute|
        self.send(:attr_accessor, attribute)
      end
    end
  end


  def updateContent(value)
    @html_content = Nokogiri::XML(value)
    set_data_to_variable
  end


  def set_data_to_variable

    @@attributes.each do |attribute|
      var_name = "div#"+attribute.to_s
      if (@html_content.css(var_name).length >1)
        value =[]
        for i in 0..@html_content.css(var_name).length-1
          value << (@html_content.css(var_name)[i].text)
        end
        instance_variable_set("@"+attribute.to_s, value)
      else
        value = @html_content.css(var_name)[0].text
        instance_variable_set("@"+attribute.to_s, value)
      end
    end
  end

end