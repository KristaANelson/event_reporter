require_relative 'messages'
require 'pry'
require_relative 'cli'

class Helper

 attr_reader :file_name, :remaining_input, :messages, :outstream, :instream

 def initialize(instream, outstream)
   @instream = instream
   @outstream = outstream
   @messages = Messages.new
   # @remaining_input
 end

 def process_help(remaining_input)
   if remaining_input == []
     outstream.puts messages.help
   elsif remaining_input == ["find"]
     outstream.puts messages.help_find
   elsif remaining_input == ["search"]
     outstream.puts messages.help_search
   elsif remaining_input ==["queue"]
     outstream.puts messages.help_queue
   elsif remaining_input ==["queue","clear"]
     outstream.puts messages.help_queue_clear
   elsif remaining_input ==["queue","count"]
     outstream.puts messages.help_queue_count
   elsif remaining_input ==["queue","save"]
     outstream.puts messages.help_queue_save
   elsif remaining_input ==["queue","print"]
     outstream.puts messages.help_queue_print
   end
 end
end
 # def self.process_help(@user_input)
 #   @user_input = "help" if @remaining_input == []
 #   #  then outstream puts message.queue
 #   # case @remaining_input[0]
 #   #   when 'clear' then outstream.puts message.queue_clear
 #   #   when 'print' then outstream.puts message.queue_print
 #   #   when 'save'  then outstream.puts message.queue_save
 #   #   when 'count' then outstream.puts message.queue_count
 #   #   end
 #   # when 'find' then outstream.puts message.find_help
 #   end
 # end
