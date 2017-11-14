class ContactsController < ApplicationController
  def print_first_contact
    render json: Contact.find_by("id":1).as_json
  end

  def print_all_contacts
    render json: Contact.all.sort_by {|x| x["id"]}.as_json
  end

  def print_contact_friendly
    contacts = Contact.all.sort_by {|x| x["id"]}

    text = ""
    contacts.each do |person|
      text += "#{person["first_name"]} #{person["last_name"]}\n"
      text += "Email: #{person["email"]}\n"
      text += "Phone Number: #{person["phone_number"]}\n\n"
    end

    render json: text
  end
end
