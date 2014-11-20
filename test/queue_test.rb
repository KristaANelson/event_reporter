require_relative 'test_helper'
require           'results_queue'
require 'messages'


class QueueHolderTest < Minitest::Test

 def test_it_starts_with_a_queue_count_of_0
   queue = ResultsQueue.new('in','out')
   assert_equal nil, queue.q_results
 end

 def test_it_holds_entries
   queue = ResultsQueue.new('in','out')
   queue.q_results = [1,2]
   assert_equal 2, queue.q_results.count
 end

def test_it_retrieves_count
 queue = ResultsQueue.new('in','out')
 queue.q_results = [1,2,3,4,5]
 refute queue.q_results.empty?
 assert_equal 5, queue.q_results.count
end
#
def test_it_clears_queue
  message = Messages.new
 queue = ResultsQueue.new($stdin,$stdout)
 queue.q_results = [1,2]
 refute queue.q_results.empty?

 queue.clear

 assert queue.q_results.empty?
end
end
