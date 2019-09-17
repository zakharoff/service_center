class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  validates :fullname, :phone, presence: true
  validates :phone, numericality: { only_integer: true }
end
