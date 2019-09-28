require 'rails_helper'

RSpec.describe Form, type: :model do
  it { should have_many(:organizations).dependent(:destroy) }
  it { should validate_presence_of :form }
end
