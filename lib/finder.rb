require 'loader'
require 'pry'
require 'cli'
require 'results_queue'

class Finder
  attr_reader :user_input, :entries, :instream, :outstream
  attr_accessor :finder_results, :attribute, :criteria

  def initialize(entries)
    @entries = entries
    @finder_results = []
  end

  def process_find(remaining_input)
    break_down_remaining_input(remaining_input)
  end

  def break_down_remaining_input(remaining_input)
    remaining_input.shift
    self.attribute = remaining_input.delete_at(0)
    self.criteria = remaining_input.join(" ")
    available_attributes = ['reg_date','last_Name','first_name','email','zipcode', 'city','state','street', 'phone']
    if available_attributes.include?(attribute)
      self.finder_results = find_by(attribute, criteria)
    else
      puts "'#{attribute}' is an invalid search attribute. Please use one of the following attributes: #{available_attributes.join(", ")}."
    end
  end

  def find_by(attribute, criteria)
    @entries.select do |entry|
      entry.send(attribute) == criteria
    end
  end
end
