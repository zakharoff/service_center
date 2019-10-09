class Organization < ApplicationRecord
  belongs_to :form
  has_many :devices, dependent: :nullify
  has_many :clients_organizations, dependent: :destroy
  has_many :clients, through: :clients_organizations

  validates :name, :inn, :ogrn, presence: true
  validates :inn, :ogrn, numericality: { only_integer: true }
  validates :inn, length: { is: 6 }
  validates :ogrn, length: { is: 13 }
end
