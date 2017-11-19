require "unirest"
require "pp"

def create
  params = {}
  print "First name? " 
  params["first_name"] = gets.chomp
  print "Last name? "
  params['last_name'] = gets.chomp
  print "Email address? "
  params['email'] = gets.chomp
  print "Phone number? "
  params['phone_number'] = gets.chomp
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
  print "Let's test on email for contact 3. What would you like it to be? "
  params = {}
  params["email"] = gets.chomp
  response = Unirest.put("http://localhost:3000/contacts/3", parameters: params)
  pp response.body
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

while true
  system "clear"
  response = Unirest.get("http://localhost:3000/contacts")
  contacts = response.body
  contacts.each do |person|
    puts "#{person["first_name"]} #{person["last_name"]}"
    puts "Email: #{person["email"]}"
    puts "Phone Number: #{person["phone_number"]}"
    puts
  end

  puts "What would you like to do?"
  puts "1. Create"
  puts "2. Read"
  puts "3. Update"
  puts "4. Destroy"
  choice = gets.chomp.to_i
  if choice == 0
    break
  elsif choice == 1
    create
  elsif choice == 2
    read
  elsif choice == 3
    update
  elsif choice == 4
    destroy
  end
  gets.chomp
end