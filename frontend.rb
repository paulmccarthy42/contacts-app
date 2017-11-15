require "unirest"

def create
  pass
end

def read
  pass
end

def update
  pass
end

def destroy
  pass
end

response = Unirest.get("http://localhost:3000/all_contacts")

contacts = response.body

contacts.each do |person|
  puts "#{person["first_name"]} #{person["last_name"]}"
  puts "Email: #{person["email"]}"
  puts "Phone Number: #{person["phone_number"]}"
  puts
end

while true
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
  end
end