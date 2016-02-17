require 'nokogiri'


module HtmlParser
  @html_content


  def updateContent(value)
    @html_content = Nokogiri::XML(value)
    # temp = @html_content.css('div')[0]['id']
    # puts (temp)
    #
    # temp  = @html_content.css('div').length
    # puts (temp)

    set_data_to_variable
  end

  def method_missing(method_id, *arguments, &block)
    puts (method_id)
  end

  def set_data_to_variable
    for i in 0..@html_content.css('div').length-1
      var_name = @html_content.css('div')[i]['id']
      var_name = "@"+ var_name.to_s
      value = @html_content.css('div')[i].text
      instance_variable_set(var_name,value)
    end
  end


end