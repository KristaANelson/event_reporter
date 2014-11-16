
class Search

def lookup_by_reg_date (data, user_input)
  @queue = data.select do |r_date|
    r_date[0] == user_input
end



end
