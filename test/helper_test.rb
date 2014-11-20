require_relative 'test_helper'
require 'stringio'
require 'helper'

class TestHelper <Minitest::Test


 def test_print_load_help
   outstream = StringIO.new
   helper = Helper.new(outstream, nil)
   helper.help_load
   text = "'load' will load 'event_attendees.csv'"
   assert outstream.string.include?(text)
 end


 def test_print_help
   outstream = StringIO.new
   helper = Helper.new(outstream, nil)
   helper.help
   text = "What would you like help on? Please choose from the following options"
   assert outstream.string.include?(text)
 end

 def test_print_help_queue
   outstream = StringIO.new
   helper = Helper.new(outstream, nil)
   helper.help_queue
   text = "What would you like help with in regards to queue? Pick from the following options"
   assert outstream.string.include?(text)
 end


 def test_print_help_find
   outstream = StringIO.new
   helper = Helper.new(outstream, nil)
   helper.help_find
   text = "You can find by the following attirbutes:"
   assert outstream.string.include?(text)
 end

 def test_print_help_queue_count
   outstream = StringIO.new
   helper = Helper.new(outstream, nil)
   helper.help_queue_count
   text = "queue count' will return the number of results that were found"
   assert outstream.string.include?(text)
 end


 def test_print_help_queue_save
   outstream = StringIO.new
   helper = Helper.new(outstream, nil)
   helper.help_queue_save
   text = "queue save to filename' will take the results from your previous search "
   assert outstream.string.include?(text)
 end


 def test_print_help_queue_print
   outstream = StringIO.new
   helper = Helper.new(outstream, nil)
   helper.help_queue_print
   text =  "queue print' will take the results from your previous search"
   assert outstream.string.include?(text)
 end

 def test_print_help_queue_clear
   outstream = StringIO.new
   helper = Helper.new(outstream, nil)
   helper.help_queue_clear
   text = "queue clear' will remove any results currently stored from your previous search."
 end
end
