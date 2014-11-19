require_relative 'messages'
require_relative 'loader'
require_relative 'helper'
require 'pry'


class CLI
  attr_reader :instream, :outstream, :message, :input, :remaining_input, :loader
  attr_accessor :command, :property

  def initialize(instream, outstream)
    @instream = instream
    @outstream = outstream
    @input = ""
    @message = Messages.new
    @loader = Loader.new
    @helper = Helper.new(instream, outstream)
    @command = ''
    @remaining_input = []
  end

  def call
    outstream.puts message.intro_message
    until exit?
      @input = instream.gets.strip
      determine_command
      process_initial_commands
    end
  end

  def process_initial_commands
    case
    when load?            then loader.process_load(@remaining_input)
    when help?            then process_help
    when queue?           then process_queue
    when find?            then process_find
    when exit?            then outstream.puts message.exit
    else  outstream.puts message.invalid_message
    end
  end

  def determine_command
  @remaining_input = @input.downcase.split
  self.command = @remaining_input.delete_at(0)
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
