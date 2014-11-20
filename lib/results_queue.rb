require 'terminal-table'
require 'pry'
require 'finder'
require 'saver'

class ResultsQueue
attr_reader :message, :remaining_input, :instream, :outstream, :response, :saver
attr_accessor :q_results, :rows_left_to_print

  def initialize(instream, outstream)
    @instream  = instream
    @outstream = outstream
    @message   = Messages.new
    @saver     = Saver.new(instream, outstream)
    @response  = ""
  end

  def process_queue(remaining_input, results)
    @q_results = results
    @remaining_input = remaining_input
    case
    when  remaining_input == ["count"]   then  count
    when  remaining_input == ["clear"]   then  clear
    when  remaining_input == ["print"]   then  print_by
    when  remaining_input[0] == "save"   then  saver.save(remaining_input, q_results)
    when  remaining_input[0] == "print"  then  determine_attribute
    else
      outstream.puts message.invalid_message
    end
  end

  def count
    outstream.puts  message.queue_count(q_results).green
  end

  def clear
    outstream.puts message.queue_clear.green
    @q_results = []
  end

  def print_by(attribute='last_name')
    if q_results.empty?
      outstream.puts message.empty_queue.red
    else
      @rows_left_to_print = q_results.sort_by {|q| q.send(attribute)}
      until stop_printing?
        print_table(rows_left_to_print.shift(10))
        outstream.puts message.table_cont.yellow
        @response = gets
      end
      unless response.strip == "exit"
        print_table(rows_left_to_print.shift(rows_left_to_print.size))
      end
    end
  end

  def determine_attribute
    attribute = remaining_input.pop
    available_attributes = [
                            'last_name',
                            'first_name',
                            'email',
                            'zipcode',
                            'city',
                            'state',
                            'street',
                            'phone'
                            ]
    if available_attributes.include?(attribute)
      print_by(attribute)
    else
      outstream.puts message.print_by_attributes(attribute, available_attributes).red
    end
  end

  def print_table(print_these)
  rows = []
  print_these.each do |entry|
  rows << [
          "#{entry.last_name.capitalize}".ljust(10).green,
          "#{entry.first_name.capitalize}".ljust(10).green,
          "#{entry.email}".ljust(35).green,
          "#{entry.zipcode}".ljust(7).green,
          "#{entry.city.capitalize}".ljust(15).green,
          "#{entry.state.upcase}".ljust(6).green,
          "#{entry.street}".ljust(45).green,
          "#{entry.phone}".ljust(13).green
          ]
    end
    table = Terminal::Table.new :title => "Queue Results".yellow, :headings => ['LAST NAME'.purple, 'FIRST NAME'.purple, 'EMAIL'.purple, 'ZIPCODE'.purple, 'CITY'.purple, 'STATE'.purple, 'ADDRESS'.purple, 'PHONE'.purple], :rows => rows
    outstream.puts table
  end

  def stop_printing?
    rows_left_to_print.size < 10 || response.strip == 'exit'
  end
end
