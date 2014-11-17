require 'pry'
class Attendee
  attr_reader :reg_date, :first_name, :last_name, :email, :phone, :street, :city, :state, :zipcode

  def initialize(data)
    @reg_date = data[:reg_date]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @email = data[:email]
    @phone = data[:phone]
    @street = data[:street]
    @city = data[:city]
    @state = data[:state]
    @zipcode = data[:zipcode]
  end

end
