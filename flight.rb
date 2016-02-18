require './html_parser'
class Flight
  include HtmlParser
  attr :flight_no, :pilot

  def initialize (css_data)
    updateContent(css_data)
  end
end

flight = Flight.new('<?xml version="1.0"?><div class="flight"><div id="flight_no">10</div> <div id="flight_no">11</div> <div class="info"><div id="pilot">Superman</div></div></div>')
puts (flight.flight_no)
puts (flight.pilot)



