require 'pry'
require 'csv'

class Loader
  attr_accessor :entries
  attr_reader :file_name

def initialize
  @file_name = ""
  @entries = []
end

  def load_file
    CSV.foreach("./data/#{file_name}", headers: true) do |row|
      @entries << [row[1],row[2],row[3],row[4],row[5],row[6],row[7],row[8],row[9]]
    end
    puts @entries[0]
  end

  def process_load(remaining_input)
    if remaining_input == []
      @file_name = "event_attendees.csv"
    else
      @file_name = remaining_input[0]
    end
    load_file
  end
end
