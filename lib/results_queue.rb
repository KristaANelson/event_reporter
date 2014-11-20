require 'terminal-table'
require 'pry'
require 'finder'
require 'saver'
require 'table_printer'

class ResultsQueue
attr_reader :message, :remaining_input, :instream, :outstream, :response, :saver, :table_printer
attr_accessor :q_results, :rows_left_to_print

  def initialize(instream, outstream)
    @instream  = instream
    @outstream = outstream
    @message   = Messages.new
    @saver     = Saver.new(instream, outstream)
    @response  = ""
    @table_printer = TablePrinter.new(instream, outstream)
  end

  def process_queue(remaining_input, results)
    @q_results = results
    @remaining_input = remaining_input
    case
    when  remaining_input == ["count"]   then  count
    when  remaining_input == ["clear"]   then  clear
    when  remaining_input == ["print"]   then  table_printer.print_by(q_results)
    when  remaining_input[0] == "save"   then  saver.save_file(remaining_input, q_results)
    when  remaining_input[0] == "print"  then  table_printer.determine_attribute(remaining_input, q_results)
    else
      outstream.puts message.invalid_message.red
    end
  end

  def count
    outstream.puts  message.queue_count(q_results).green
  end

  def clear
    outstream.puts message.queue_clear.green
    @q_results = []
  end


end
