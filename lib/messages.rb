class Messages
  def help
    "What would you like help on? Please choose from the following options:
    help find
    help load
    help queue
    help queue count
    help queue clear
    help queue save
    help queue print"
  end

  def intro_message
    "Welcome to Entry Repository."
  end

  def next_command
    "Enter your command.\n> "
  end

  def load_message(file_name)
    "File '#{file_name}' has been loaded."
  end

  def exit
    "exit"
  end

  def invalid_message
    "Invalid entry, please try again. "
  end

  def help_load
    "'load' will load 'event_attendees.csv' or if you have a specific file you would like to load, you can enter 'load example_file.csv'."
  end

  def help_queue_clear
    "'queue clear' will remove any results currently stored from your previous search."
  end

  def help_queue_count
    "'queue count' will return the number of results that were found and placed in the queue from your last search."
  end

  def help_queue_save
    "'queue save to filename' will take the results from your previous search and save it to the given filename.
    This will save the file as a CSV file, so no need to inlucde '.csv' in your filename."
  end

  def help_queue_print
    "'queue print' will take the results from your previous search and display a table with the following information:
    LAST NAME | FIST NAME | EMAIL | ZIPCODE | CITY | STATE | ADDRESS | PHONE"
  end

  def help_queue
    "What would you like help with in regards to queue? Pick from the following options
    help queue count
    help queue clear
    help queue print"
  end

  def help_find
    "You can find by the following attirbutes:
    first_name
    last_name
    email
    phone
    street
    city
    state
    reg_date"
  end

  def empty_queue
    "Sorry your queue is empty please try your search again by using 'find by'"
  end
end
