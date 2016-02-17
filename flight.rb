require './html_parser'
class Flight
  include HtmlParser
  attr :enjoy

  def initialize (css_data)
    updateContent(css_data)
  end
end

flight = Flight.new("<div id=\"enjoy\">Enjoy</div>")
puts (flight.enjoy)

