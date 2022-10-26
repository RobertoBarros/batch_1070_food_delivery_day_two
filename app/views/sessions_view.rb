class SessionsView
  def ask_username
    puts "Username?"
    gets.chomp
  end

  def ask_password
    puts "Password?"
    gets.chomp
  end

  def welcome(username)
    puts "Welcome #{username}"
  end

  def wrong_credentials
    puts "Wrong credentials. Try again..."
  end
end
