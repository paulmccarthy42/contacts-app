class UsersController < ApplicationController
  def create
    new_user = User.new(
      name: params["name"],
      email: params["email"],
      password:  params["password"],
      password_confirmation: params["password_confirmation"]
      )
    if new_user.save
      render json: new_user.as_json
    else
      render json: {errors: new_contact.errors.full_messages}, status: :bad_request
    end
  end
end
