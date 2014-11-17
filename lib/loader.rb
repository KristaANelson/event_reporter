require 'pry'
require 'CSV'

# require_relative '../event_attendees.csv'

class Loader
  attr_reader :file_name
def initialize
  @file_name = ""
end

  def self.load_file
    contents = CSV.open("./data/#{@file_name}", headers: true)
  end

  def self.process_load(property)
    @file_name = "event_attendees.csv" if property == nil
    @file_name = property
    self.load_file
  end
end
