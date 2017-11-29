require "unirest"
require "pp"

def display
  response = Unirest.get("http://localhost:3000/contacts")
  contacts = response.body
  contacts.each do |person|
    puts "#{person["first_name"]} #{person["middle_name"]} #{person["last_name"]}"
    puts "Bio: #{person["bio"]}"
    puts "Email: #{person["email"]}"
    puts "Phone Number: #{person["phone_number"]}"
    puts
  end
end

def create
  params = {}
  print "First name? " 
  params["first_name"] = gets.chomp
  print "Middle name? "
  params["middle_name"] = gets.chomp
  print "Last name? "
  params['last_name'] = gets.chomp
  print "Email address? "
  params['email'] = gets.chomp
  print "Phone number? "
  params['phone_number'] = gets.chomp
  print "Basic Description: "
  params["bio"] = gets.chomp
  response = Unirest.post("http://localhost:3000/contacts", parameters: params)
  puts response.code == 200 ? "Success" : "Sorry, code #{response.code}. Please try again later. Errors #{response.body["errors"]}"
end

def read
  puts "What id do you want?"
  input_id = gets.chomp.to_i
  response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
  pp response.body
end

def update
  print "Let's test on phone for contact 2. What would you like it to be? "
  params = {}
  params["phone_number"] = gets.chomp
  response = Unirest.put("http://localhost:3000/contacts/2", parameters: params )
  puts response.code == 200 ? "Success" : "Sorry, code #{response.code}. Please try again later. Errors #{response.body["errors"]}"
end

def destroy
  print "Which ID would you like to destroy"
  response = Unirest.get("http://localhost:3000/contacts")
  contacts = response.body
  contacts.each do |person|
    puts "#{person["id"]}. #{person["first_name"]}"
  end
  id = gets.chomp.to_i
  response = Unirest.delete("http://localhost:3000/contacts/#{id}")
  puts response.body
end

def search
  puts "would you like to search by"
  puts "[1] First name"
  puts "[2] Last name"
  puts '[3] Email'
  query = [nil, "first_name", "last_name", "email"]
  params = {}
  params[:search_field] = query[gets.chomp.to_i]
  puts "What would you like to search for?"
  params[:search_input] = gets.chomp
  params[:search_field] = nil if params[:search_field] == ""
  params[:search_input] = nil if params[:search_input] == ""
  response = Unirest.get("http://localhost:3000/contacts", 
    parameters: params)
  contacts = response.body
  contacts.each do |person|
    puts "#{person["first_name"]} #{person["middle_name"]} #{person["last_name"]}"
    puts "Bio: #{person["bio"]}"
    puts "Email: #{person["email"]}"
    puts "Phone Number: #{person["phone_number"]}"
    puts
  end
end

def signup
  params = {}
  print "Name: "
  params["name"] = gets.chomp
  print "Email: "
  params["email"] = gets.chomp
  print "Password: "
  params["password"] = gets.chomp
  print "Confirm Password: "
  params["password_confirmation"] = gets.chomp
  response = Unirest.post("http://localhost:3000/users", parameters: params)
  puts response.body
end

def login
  params = {}
  print "Email: "
  params["email"] = gets.chomp
  print "Password: "
  params["password"] = gets.chomp
  response = Unirest.post("http://localhost:3000/user_token", 
    parameters: {auth: params})
  p response.body
  jwt = response.body["jwt"]
  Unirest.default_header("Authorization", "Bearer #{jwt}")
end

def logout
  Unirest.clear_default_headers()
end

routing = [method(:display),
  method(:create),
  method(:read),
  method(:update),
  method(:destroy),
  method(:search),
  method(:signup),
  method(:login),
  method(:logout)
]

while true
  system "clear"

  puts "What would you like to do?"
  routing.each do |method|
    puts "#{routing.index(method)}. #{method.name.capitalize}"
  end
  choice = gets.chomp
  choice_num = choice.to_i
  if choice_num < 0 || choice_num > routing.length || choice_num.to_s != choice
    break
  else
    routing[choice_num].call
  end
  gets.chomp
end