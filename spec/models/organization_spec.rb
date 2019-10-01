require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { should belong_to :form }
  it { should have_many :devices }
  it { should have_many(:clients_organizations).dependent(:destroy) }
  it { should have_many(:clients).through(:clients_organizations) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :inn }
  it { should validate_presence_of :ogrn }
  it { should validate_numericality_of :inn }
  it { should validate_numericality_of :ogrn }
  it { should validate_length_of(:inn).is_equal_to(6) }
  it { should validate_length_of(:ogrn).is_equal_to(13) }
end
