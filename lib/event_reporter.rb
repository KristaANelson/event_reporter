require 'pry'
require 'csv'

class EventReporter
  # "EventReporter initialized."

  contents = CSV.open "../event_attendees.csv", headers: true
  contents.each do |row|
  index         = row[0]
  date          = row[1]
  first_name    = row[2]
  last_name     = row[3]
  email         = row[4]
  home_phone    = row[5]
  street        = row[6]
  city          = row[7]
  state         = row[8]
  zipcode       = row[9]
  puts zipcode
   end
   binding.pry

end
def initialize
  data = []
end
  def (fileneame)
CSV.foreach(filename, row
