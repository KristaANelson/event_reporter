require 'terminal-table'
require 'pry'
require 'finder'

class ResultsQueue
attr_reader :message, :remaining_input, :instream, :outstream, :file_path
attr_accessor :queue_results, :save_to_file

  def initialize(instream, outstream)
    @instream = instream
    @outstream = outstream
    @message = Messages.new
  end

  def process_queue(remaining_input, results)
    self.queue_results = results
    if remaining_input.size == 1
      short_command(remaining_input, queue_results)
    else
      long_command(remaining_input)
    end
  end

  def short_command(remaining_input, queue_results)
    if remaining_input == ["count"]
      count
    elsif remaining_input == ["clear"]
      clear
    elsif remaining_input == ["print"]
      printer
    else
      outstream.puts message.invalid_message
    end
  end

  def long_command(remaining_input)
    if remaining_input[0] == "save"
      save(remaining_input)
    else
      print_by
    end
  end


  def count
    puts "#{queue_results.count}"
  end

  def clear
    puts "queue cleared!"
    #need to find a way to access results in finder and update it.
    self.queue_results = []
  end

  def printer
    if queue_results.empty?
      outstream.puts message.empty_queue
    else
    rows = []
    queue_results.each do |entry|
      rows << [
        "#{entry.last_name.capitalize}",
        "#{entry.first_name.capitalize}",
        "#{entry.email}",
        "#{entry.zipcode}",
        "#{entry.city.capitalize}",
        "#{entry.state}",
        "#{entry.street}",
        "#{entry.phone}"
        ]
      end
    table = Terminal::Table.new :title => "Queue Results", :headings => ['LAST NAME', 'FIRST NAME', 'EMAIL', 'ZIPCODE', 'CITY', 'STATE', 'ADDRESS', 'PHONE'], :rows => rows
    puts table
    end
  end

  def print_by_attribute(attribute)
    @attendees.sort_by do |attendee|
      attendee.send(attribute)
    end
  end

  def save(remaining_input)
    determine_file_path(remaining_input)
    CSV.open(file_path, "wb") do |file|
    file << ['reg_date','last_Name','first_name','email','zipcode', 'city','state','street', 'phone']
    queue_results.each do |entry|
      file << [entry.reg_date, entry.last_name, entry.first_name, entry.email, entry.zipcode, entry.city, entry.state, entry.street,entry.phone]
      end
    end
    outstream.puts "Your file '#{file_path}' has been created!"
  end

  def determine_file_path(remaining_input)
    save_to_file = remaining_input.pop
    @file_path = "./data/#{save_to_file}.csv"
  end


  def find
  end
end
