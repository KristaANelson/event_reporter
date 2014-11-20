require 'terminal-table'
require 'pry'
require 'finder'

class ResultsQueue
attr_reader :message, :remaining_input, :instream, :outstream, :file_path, :response
attr_accessor :queue_results, :save_to_file, :response, :rows_left_to_print

  def initialize(instream, outstream)
    @instream = instream
    @outstream = outstream
    @message = Messages.new
    @response = ""
  end

  def process_queue(remaining_input, results)
    self.queue_results = results
    if remaining_input[0] == "count"
      count
    elsif remaining_input[0] == "clear"
      clear
    elsif remaining_input == ["print"]
      printer('last_name')
    elsif remaining_input[0] == "save"
      save(remaining_input)
    elsif remaining_input[0] == "print"
      attribute = remaining_input.pop
      available_attributes = ['last_name','first_name','email','zipcode', 'city','state','street', 'phone']
      if available_attributes.include?(attribute)
        printer(attribute)
      else
        puts "'#{attribute}' is an invalid print by attribute. Please use one of the following attributes: #{available_attributes.join(", ")}.".red
      end
    else
        outstream.puts message.invalid_message
    end
  end


  def count
    puts "#{queue_results.count}"
  end

  def clear
    puts "The queue has been cleared!".yellow
    self.queue_results = []
  end

  def printer(attribute='last_name')
    if queue_results.empty?
      outstream.puts message.empty_queue
    else
    @rows_left_to_print = queue_results.sort_by {|q| q.send(attribute)}
    until keep_printing?
      table(rows_left_to_print.shift(10))
      puts "To be continuted... Press enter for next page or 'exit' to be promted for next command."
      self.response = gets
    end
    unless response.strip == "exit"
    table(rows_left_to_print.shift(rows_left_to_print.size))
    puts "End of table"
    end
    end
  end

  def table(print_these)
  rows = []
  print_these.each do |entry|
  rows << [
          "#{entry.last_name.capitalize}".ljust(10).yellow,
          "#{entry.first_name.capitalize}".ljust(10).yellow,
          "#{entry.email}".ljust(35).yellow,
          "#{entry.zipcode}".ljust(7).yellow,
          "#{entry.city.capitalize}".ljust(15).yellow,
          "#{entry.state.upcase}".ljust(6).yellow,
          "#{entry.street}".ljust(45).yellow,
          "#{entry.phone}".ljust(13).yellow
          ]
    end
    table = Terminal::Table.new :title => "Queue Results".green, :headings => ['LAST NAME'.purple, 'FIRST NAME'.purple, 'EMAIL'.purple, 'ZIPCODE'.purple, 'CITY'.purple, 'STATE'.purple, 'ADDRESS'.purple, 'PHONE'.purple], :rows => rows
    puts table
end

  def keep_printing?
    rows_left_to_print.size < 10 || response.strip == 'exit'
  end

  def save(remaining_input)
    determine_file_path(remaining_input)
    CSV.open(file_path, "wb") do |file|
    file << ['reg_date','last_Name','first_name','email','zipcode', 'city','state','street', 'phone']
    queue_results.each do |entry|
      file << [entry.reg_date, entry.last_name, entry.first_name, entry.email, entry.zipcode, entry.city, entry.state, entry.street,entry.phone]
      end
    end
    outstream.puts "Your file '#{file_path}' has been created!".yellow
  end

  def determine_file_path(remaining_input)
    save_to_file = remaining_input.pop
    @file_path = "./data/#{save_to_file}.csv"
    if File.exists?(@file_path)
      outstream.puts "WARNING FILE ALREADY CREATED PLEASE BE AWARE CONTINUED NAME USE MAY CAUSE DATA DUPLICATION".red
      @file_path = "./data/#{save_to_file}_1.csv"
    end
  end

end
