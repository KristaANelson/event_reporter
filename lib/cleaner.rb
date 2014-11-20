class Cleaner

  def clean_name(name)
    if name.nil? || name.empty?
      ""
    else
      name.strip.downcase
    end
  end

  def clean_zipcode(zipcode)
    zipcode.to_s.ljust(5,"0")[0..4]
  end

  def clean_phone(phone)
    if phone.nil? || phone.empty?
      ""
    else phone.match(/^1?(\d{3})(\d{3})(\d{4})/)
      [$1,$2,$3].join("-")
    end
  end

  def clean_city(city)
    if city.nil? || city.empty?
      ""
    elsif city.match(/,/)
       city.strip.downcase.match(/,/).pre_match
    else
      city.strip.downcase
    end
  end

  def clean_email(email)
   if email.nil? || email.empty?
   ""
     else
     md = email.match(/[\w]+@[\w]+.[\w]+/)
     md[0]
   end
   end

  def clean_state(state)
    if state.nil? || state.empty?
      ""
    else
      state.strip.downcase
    end
  end
end
