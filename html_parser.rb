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
      value = @html_content.css(var_name).text
      instance_variable_set("@"+attribute.to_s, value)

    end
  end

end