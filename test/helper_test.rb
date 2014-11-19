require_relative 'test_helper'

class TestHelper

  def test_user_get_help
    helper = Helper.new(nil,nil)
    helper.stub :remaining_input, [] do
    assert cli.help?
    refute cli.load?
  end
end
