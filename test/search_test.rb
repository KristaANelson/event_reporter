require_relative 'test_helper'
require_relative '../lib/search'


class SearchTest < Minitest::Test

    def test_it_can_search
        search = Search.new(nil)
        search.stub :user_input, "regdate"
        assert 80205, search.regdate
      end

end
