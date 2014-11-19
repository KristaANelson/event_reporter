require_relative 'test_helper'
require_relative '../lib/queue'


class QueueHolderTest < Minitest::Test
  def test_it_starts_with_a_queue_count_of_0
    queue_holder = QueueHolder.new
    assert_equal 0, queue_holder.count
  end

  def test_it_holds_entries
    queue_holder = QueueHolder.new
    found = 
  end
end
