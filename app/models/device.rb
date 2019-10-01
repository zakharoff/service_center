class Device < ApplicationRecord
  belongs_to :type_device
  belongs_to :organization, optional: true

  validates :name, :serial_num, presence: true
end
