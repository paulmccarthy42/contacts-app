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
  puts response.code == 200 ? "Success" : "Sorry, code #{response.code}. Please try again later"
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
  puts response.code == 200 ? "Success" : "Sorry, code #{response.code}. Please try again later"
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

routing = [method(:display),
  method(:create),
  method(:read),
  method(:update),
  method(:destroy)
]

while true
  system "clear"
  display

  puts "What would you like to do?"
  routing.each do |method|
    puts "#{routing.index(method)}. #{method.name.capitalize}"
  end
  choice = gets.chomp
  choice_num = choice.to_i
  if choice_num < 0 || choice_num > 5 || choice_num.to_s != choice
    break
  else
    routing[choice_num].call
  end
  gets.chomp
end