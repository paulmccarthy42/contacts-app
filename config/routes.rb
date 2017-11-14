Rails.application.routes.draw do
  get "/contact/:input" => "contacts#print_first_contact"
  get "/all_contacts" => "contacts#print_all_contacts"
  get "/web_friendly_contacts" => "contacts#print_contact_friendly"
end
