require 'rails_helper'

RSpec.describe Device, type: :model do
  it { should belong_to :type_device }

  it { should validate_presence_of :name }
  it { should validate_presence_of :serial_num }
end
