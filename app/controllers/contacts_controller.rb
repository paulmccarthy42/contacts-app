class ContactsController < ApplicationController
  def index
    render json: Contact.all
  end

  def create
    new_contact = Contact.new(
      first_name: params["first_name"],
      last_name: params["last_name"],
      email: params["email"],
      phone_number: params["phone_number"])
    new_contact.save
    render json: new_contact
  end

  def show
    id = params["id"]
    render json: Contact.find_by(id: id).as_json
  end

  def update
    chosen_contact = Contact.find_by(id: params["id"])
    chosen_contact.first_name = params["first_name"] || chosen_contact.first_name
    chosen_contact.last_name = params["last_name"] || chosen_contact.last_name
    chosen_contact.email = params["email"] || chosen_contact.email
    chosen_contact.phone_number = params["phone_number"] || chosen_contact.phone_number
    chosen_contact.save
    render json: chosen_contact
  end

  def destroy
    chosen_contact = Contact.find_by(id: params["id"])
    chosen_contact.destroy
    render json: "Successfully destroyed"
  end
end
