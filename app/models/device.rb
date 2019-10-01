class Device < ApplicationRecord
  belongs_to :type_device

  validates :name, :serial_num, presence: true
end
