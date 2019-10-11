class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  has_many :clients_organizations, dependent: :destroy
  has_many :organizations, through: :clients_organizations

  validates :fullname, :phone, presence: true
end
