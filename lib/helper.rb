require_relative 'messages'
require 'pry'
require_relative 'cli'

class Helper
  attr_reader :file_name, :remaining_input, :messages, :outstream, :instream

  def initialize(outstream, instream)
    @instream = instream
    @outstream = outstream
    @messages = Messages.new
  end

  def process_help(remaining_input)
    @remaining_input = remaining_input
    case
    when  help?        then help
    when  find?        then help_find
    when  search?      then help_search
    when  load?        then help_load
    when  queue?       then help_queue
    when  queue_clear? then help_queue_clear
    when  queue_count? then help_queue_count
    when  queue_save?  then help_queue_save
    when  queue_print? then help_queue_print
    end
  end

  def help?
    remaining_input == []
  end

  def load?
    remaining_input = ["load"]
  end

  def find?
    remaining_input == ["find"]
  end

  def search?
    remaining_input == ["search"]
  end

  def queue?
    remaining_input == ["queue"]
  end

  def queue_clear?
    remaining_input == ["queue","clear"]
  end

  def queue_count?
    remaining_input == ["queue","count"]
  end

  def queue_save?
    remaining_input == ["queue","save"]
  end

  def queue_print?
    remaining_input == ["queue","print"]
  end

  def help
    outstream.puts messages.help
  end

  def help_find
    outstream.puts messages.help_find
  end

  def help_load
    outstream.puts messages.help_load
  end

  def help_search
    outstream.puts messages.help_search
  end

  def help_queue
    outstream.puts messages.help_queue
  end

  def help_queue_clear
    outstream.puts messages.help_queue_clear
  end

  def help_queue_count
    outstream.puts messages.help_queue_count
  end

  def help_queue_save
    outstream.puts messages.help_queue_save
  end

  def help_queue_print
    outstream.puts messages.help_queue_print
  end
end
