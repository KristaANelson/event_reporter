require_relative 'test_helper'
require 'entry'

class EntryTest < Minitest::Test
 def test_it_has_a_name
   data = { regdate: "11/12/08 10:47",first_name: "Allison",last_name: "Nguyen",
     email_address: "arannon@jumpstartlab.com",
     homephone:"6154385000",
     street:"3155 19th St NW",
     city:"Washington",
     state:"DC",
     zipcode:"20010"}

   entry = Entry.new(data)
   assert_equal "allison", entry.first_name
 end

 def test_it_has_a_zipcode
   data = { regdate: "11/12/08 10:47",first_name: "Allison",last_name: "Nguyen",
     email_address: "arannon@jumpstartlab.com",
     homephone:"6154385000",
     street:"3155 19th St NW",
     city:"Washington",
     state:"DC",
     zipcode:"2000"}

   entry = Entry.new(data)
   assert_equal "20000", entry.zipcode
 end

def test_it_has_a_phone
 data = { regdate: "11/12/08 10:47",first_name: "Allison",last_name: "Nguyen",
   email_address: "arannon@jumpstartlab.com",
   homephone:"1(615).438*@!!!5000",
   street:"3155 19th St NW",
   city:"Washington",
   state:"DC",
   zipcode:"2000"}

 entry = Entry.new(data)
 assert_equal "615-438-5000", entry.phone
end

def test_it_has_a_state
 data = { regdate: "11/12/08 10:47",first_name: "Allison",last_name: "Nguyen",
   email_address: "arannon@jumpstartlab.com",
   homephone:"6154385000",
   street:"3155 19th St NW",
   city:"Washington",
   state:"DC",
   zipcode:"2000"}

 entry = Entry.new(data)
 assert_equal "dc", entry.state
end

def test_it_has_a_city
 data = { regdate: "11/12/08 10:47",first_name: "Allison",last_name: "Nguyen",
   email_address: "arannon@jumpstartlab.com",
   homephone:"6154385000",
   street:"3155 19th St NW",
   city:"WashingTON",
   state:"dc",
   zipcode:"2000"}

 entry = Entry.new(data)
 assert_equal "washington", entry.city
end

def test_it_has_a_email
 data = { regdate: "11/12/08 10:47",first_name: "Allison",last_name: "Nguyen",
   email_address: "!!@**arannon@jumpstartlab.com",
   homephone:"6154385000",
   street:"3155 19th St NW",
   city:"WashingTON",
   state:"dc",
   zipcode:"2000"}

   entry = Entry.new(data)
   assert_equal "arannon@jumpstartlab.com", entry.email
 end
end
