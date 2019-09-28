class Form < ApplicationRecord
  has_many :organizations, dependent: :destroy

  validates :form, presence: true
end
