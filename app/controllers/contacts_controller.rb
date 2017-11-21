class ContactsController < ApplicationController
  def index
    render json: Contact.all.as_json
  end

  def create
    new_contact = Contact.new(
      first_name: params["first_name"],
      last_name: params["last_name"],
      middle_name: params["middle_name"],
      email: params["email"],
      phone_number: params["phone_number"],
      bio: params["bio"])
    new_contact.save
    render json: new_contact.as_json
  end

  def show
    id = params["id"]
    render json: Contact.find_by(id: id).as_json
  end

  def update
    chosen_contact = Contact.find_by(id: params["id"])
    chosen_contact.first_name = params["first_name"] || chosen_contact.first_name
    chosen_contact.last_name = params["last_name"] || chosen_contact.last_name
    chosen_contact.middle_name = params["middle_name"] || chosen_contact.middle_name
    chosen_contact.email = params["email"] || chosen_contact.email
    chosen_contact.phone_number = params["phone_number"] || chosen_contact.phone_number
    chosen_contact.bio = params["bio"] || chosen_contact.bio
    chosen_contact.save
    render json: chosen_contact.as_json
  end

  def destroy
    chosen_contact = Contact.find_by(id: params["id"])
    chosen_contact.destroy
    render json: "Successfully destroyed"
  end
end
