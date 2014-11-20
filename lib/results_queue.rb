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
      available_attributes = ['last_Name','first_name','email','zipcode', 'city','state','street', 'phone']
      if available_attributes.include?(attribute)
        printer(attribute)
      else
        puts "'#{attribute}' is an invalid print by attribute. Please use one of the following attributes: #{available_attributes.join(", ")}."
      end
    else
        outstream.puts message.invalid_message
    end
  end


  def count
    puts "#{queue_results.count}"
  end

  def clear
    puts "The queue has been cleared!"
    self.queue_results = []
  end

  def printer(attribute='last_name')
    if queue_results.empty?
      outstream.puts message.empty_queue
    else

    rows = []
    queue_results.sort_by {|q| q.send(attribute)}.each do |entry|
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

end
