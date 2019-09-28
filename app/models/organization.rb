class Organization < ApplicationRecord
  belongs_to :form

  validates :name, :inn, :ogrn, presence: true
  validates :inn, :ogrn, numericality: { only_integer: true }
  validates :inn, length: { is: 6 }
  validates :ogrn, length: { is: 13 }
end
