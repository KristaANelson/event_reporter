require 'pry'
class TablePrinter
  attr_reader :outstream, :message, :rows_left_to_print, :reg
  attr_accessor :response

  def initialize (instream, outstream)
    @instream = instream
    @outstream = outstream
    @message = Messages.new
    @response = ''
  end

  def print_by(q_results, attribute = 'last_name')
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

  def determine_attribute(remaining_input, q_results)
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
      print_by(q_results, attribute)
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
