require 'rails_helper'

RSpec.describe Client, type: :model do
  it { should have_many(:clients_organizations).dependent(:destroy) }
  it { should have_many(:organizations).through(:clients_organizations) }

  it { should validate_presence_of :fullname }
  it { should validate_presence_of :phone }
end
