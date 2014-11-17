require 'pry'
require 'CSV'

class Loader
  attr_reader :file_name
def initialize
  @file_name = ""
end

  def self.load_file
    contents = CSV.open("./data/#{@file_name}", headers: true)
  end

  def self.process_load(remaining_input)
    @file_name = "event_attendees.csv" if remaining_input == []
    @file_name = remaining_input[0]
    self.load_file
  end
end
