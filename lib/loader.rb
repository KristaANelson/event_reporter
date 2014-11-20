require 'entry'
require 'csv'

class Loader
  attr_accessor :entries
  attr_reader :file_name, :instream, :outstream, :messages, :remaining_input

  def initialize(instream, outstream)
    @file_name = ""
    @entries = []
    @messages = Messages.new
    @instream = instream
    @outstream = outstream
  end

  def load_file
    csv = CSV.open("./data/#{@file_name}", headers: true, header_converters: :symbol)
    csv.each do |row|
      @entries << Entry.new(row)
    end
  end

  def process_load(remaining_input)
    @remaining_input = remaining_input
    case
      when default?     then @file_name = "event_attendees.csv"
      when file_valid?  then @file_name = remaining_input[0]
      else invalid_file
    end
    load_file
    outstream.puts messages.load_message(@file_name).yellow
  end

  def file_valid?
    File.exists?("./data/#{remaining_input[0]}")  && remaining_input[0]
  end

  def default?
    remaining_input == []
  end

  def invalid_file
    outstream.puts "No file found. Loading default"
    @file_name = "event_attendees.csv"
  end
end
