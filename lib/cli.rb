require_relative 'messages'

class CLI
  attr_reader :instream, :outstream, :command, :message

  def initialize(instream, outstream)
    @instream = instream
    @outstream = outstream
    @command = ""
    @message = Message.new
  end
  #
  def call
    outstream.puts message.intro_message
    until exit?
      @command = instream.gets.strip
      process_initial_commands
    end
  end

  def process_initial_commands
      case
      when help?           then show_help
      when instructions?   then show_instructions
      when exit?           then outstream.puts message.exit
    else  outstream.puts message.invalid_message
  end
  end

def help?
  command == "help".upcase
end

def instructions?
  command == "instructions".upcase
end

def exit?
  command == "exit".upcase
end

end
