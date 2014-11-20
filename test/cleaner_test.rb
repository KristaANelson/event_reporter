require 'simplecov'
SimpleCov.start

require_relative 'test_helper'
require_relative '../lib/helper'
require_relative '../lib/cleaner'

class CleanTest < Minitest::Test

 def test_it_can_clean_first_name
   cleaner = Cleaner.new
   name = "Allison"
   cleaned_name = cleaner.clean_name(name)
   assert_equal "allison",  cleaned_name
 end

 def test_it_can_clean_last_name
   cleaner = Cleaner.new
   name = "Smith"
   cleaned_name = cleaner.clean_name(name)
   assert_equal "smith", cleaned_name
 end

 def test_it_can_clean_a_state
   cleaner = Cleaner.new
   state = "CO"
   cleaned_state = cleaner.clean_state(state)
   assert_equal "co", cleaned_state
 end

 def test_it_can_clean_a_city
   cleaner = Cleaner.new
   city = "DENver"
   cleaned_city = cleaner.clean_city(city)
   assert_equal "denver", cleaned_city
 end

 def test_it_can_clean_a_zipcode
   cleaner = Cleaner.new
   zipcode = "8020"
   cleaned_zipcode = cleaner.clean_zipcode(zipcode)
   assert_equal "80200", cleaned_zipcode
 end

 def test_it_can_clean_a_phone
   cleaner = Cleaner.new
   phone = "28021*^!55999"
   cleaned_phone = cleaner.clean_phone(phone)
   assert_equal "280-215-5999", cleaned_phone
 end


   def test_it_can_clean_a_email
     cleaner = Cleaner.new
     email = "aaaaaaa$*()hi@yahoo.com *****zzzzzzz"
     cleaned_email = cleaner.clean_email(email)
     assert_equal "hi@yahoo.com", cleaned_email
   end
end
# require_relative 'test_helper'
# require_relative '../lib/helper'
# require_relative '../lib/cleaner'
#
# class CleanTest < Minitest::Test
#
#   def test_it_can_clean_first_name
#     cleaner = Cleaner.new
#     name = "Allison"
#     cleaned_name = cleaner.clean_name(name)
#     assert_equal "allison",  cleaned_name
#     # clean_up = CleanUp.new
#     # entry1 = ["11/12/08 10:47","Allison","Nguyen","arannon@jumpstartlab.com","6154385000","3155 19th St NW","Washington","DC","20010"]
#     # entry2 = ["11/12/08 15:00","Aya","Fuller","jtex@jumpstartlab.com","778.232.7000","2-1325 Barclay Street","Vancouver","BC","90210"]
#     # entries = [entry1, entry2]
#     # clean_up.clean_first_name(entries)
#     # assert_equal "allison", entry1[1]
#     # assert_equal "aya", entry2[1]
#   end
# end
