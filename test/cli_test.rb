require 'simplecov'
SimpleCov.start

require_relative 'test_helper'
require 'cli'

class CLITest < Minitest::Test

 def test_user_get_help
   cli = CLI.new(nil,nil)
   cli.stub :command, 'help' do
     assert cli.help?
     refute cli.queue?
   end
 end

 def test_user_can_load_file
   cli = CLI.new(nil,nil)
   cli.stub :command, 'load' do
     assert cli.load?
     refute cli.help?
   end
 end

 def test_user_can_use_queue
   cli = CLI.new(nil,nil)
   cli.stub :command, 'queue' do
     assert cli.queue?
     refute cli.exit?
   end
 end
 def test_user_can_use_find
   cli = CLI.new(nil,nil)
   cli.stub :command, 'find' do
     assert cli.find?
     refute cli.exit?
   end
 end
end
