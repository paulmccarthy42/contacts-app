require "unirest"

response = Unirest.get("http://localhost:3000/all_contacts")

contacts = response.body

contacts.each do |person|
  puts "#{person["first_name"]} #{person["last_name"]}"
  puts "Email: #{person["email"]}"
  puts "Phone Number: #{person["phone_number"]}"
  puts
end