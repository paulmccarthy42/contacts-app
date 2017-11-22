class Contact < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true

  def friendly_updated_at
    updated_at.strftime("%Y %B %e, %H:%M:%S")
  end

  def full_name
    first_name + " " + last_name
  end

  def japanified_phone_number
    if phone_number == nil or phone_number == ""
      nil
    else
      return "+81 " + phone_number
    end
  end

  def as_json
    {
      id: id,
      first_name: first_name,
      last_name: last_name,
      full_name: full_name,
      middle_name: middle_name,
      email: email,
      phone_number: japanified_phone_number,
      bio: bio,
      created_at: created_at,
      updated_at: friendly_updated_at
    }
  end
end