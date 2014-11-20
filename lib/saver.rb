require 'csv'
require 'results_queue'
require 'entry'

class Saver
attr_reader :file_path, :save_to_file, :outstream, :message

  def initialize(instream, outstream)
  @instream = instream
  @outstream = outstream
  @message = Messages.new
  end

  def save_file(remaining_input, q_results)
    determine_file_path(remaining_input)
    CSV.open(file_path, "wb") do |file|
    file << [
            'reg_date',
            'last_Name',
            'first_name',
            'email',
            'zipcode',
            'city',
            'state',
            'street',
            'phone'
            ]
    q_results.each do |entry|

      file << [
              entry.reg_date,
              entry.last_name,
              entry.first_name,
              entry.email,
              entry.zipcode,
              entry.city,
              entry.state,
              entry.street,
              entry.phone
              ]
      end
    end
    outstream.puts message.file_loaded(file_path).yellow
  end

  def determine_file_path(remaining_input)
    save_to_file = remaining_input.pop
    @file_path = "./data/#{save_to_file}.csv"
    if File.exists?(file_path)
      outstream.puts message.warning_dup.red
      @file_path = "./data/#{save_to_file}_1.csv"
    end
  end
end
