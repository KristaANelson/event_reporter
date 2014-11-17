require_relative 'messages'
require_relative 'loader'
require 'pry'


class CLI
  attr_reader :instream, :outstream, :message, :input
  attr_accessor :command, :property

  def initialize(instream, outstream)
    @instream = instream
    @outstream = outstream
    @input = ""
    @message = Messages.new
    @command = ''
  end
  #
  def call
    outstream.puts message.intro_message
    until exit?
      @input = instream.gets.strip
      command_clean_up
      process_initial_commands
    end
  end

  def process_initial_commands
    case
    when load?            then Loader.process_load(property)
      binding.pry
    when help?            then process_help
    when queue?           then process_queue
    when find?            then process_find
    when exit?            then outstream.puts message.exit
    else  outstream.puts message.invalid_message
    end
  end

  def command_clean_up
  self.command, self.property = @input.downcase.split
  end

  def help?
    command == "help"
  end

  def queue?
    command == "queue"
  end

  def load?
    command == "load"
  end

  def find?
    command == "find"
  end

  def exit?
    command == "exit"
  end

end
