require 'cli'
require 'messages'

class Finder
  attr_reader :user_input, :entries, :instream, :outstream, :remaining_input, :message
  attr_accessor :finder_results, :attribute, :criteria

  def initialize(instream, outstream, entries)
    @instream = instream
    @outstream = outstream
    @entries = entries
    @finder_results = []
    @message = Messages.new
  end

  def process_find(remaining_input)
    break_down_remaining_input(remaining_input)
  end

  def break_down_remaining_input(remaining_input)
    self.attribute = remaining_input.delete_at(0)
    self.criteria = remaining_input.join(" ")
    available_attributes = [
                            'reg_date',
                            'last_name',
                            'first_name',
                            'email',
                            'zipcode',
                            'city',
                            'state',
                            'street',
                            'phone'
                            ]
    if available_attributes.include?(attribute)
      self.finder_results = find_by(attribute, criteria)
    else
      outstream.puts message.invalid_find_by(attribute, available_attributes).red
    end
  end

  def find_by(attribute, criteria)
    @entries.select do |entry|
      entry.send(attribute) == criteria
    end
  end
end
