require 'rails_helper'

RSpec.describe 'Token validation', type: :request do
  describe 'Anon' do
    it 'GET 401 client path' do
      get '/api/v1/client_auth/validate_token'

      expect(response).to have_http_status(:unauthorized)
    end

    it 'GET 401 staff path' do
      get '/api/v1/staff_auth/validate_token'

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'Client' do
    let(:client) { create :client}
    let(:auth_headers) { client.create_new_auth_token }

    sign_in :client

    it 'GET ok' do
      get '/api/v1/client_auth/validate_token'

      expect(response).to have_http_status(:success)
    end
  end

  describe 'Staff' do
    let(:staff) { create :staff}
    let(:auth_headers) { staff.create_new_auth_token }

    sign_in :staff

    it 'GET ok' do
      get '/api/v1/staff_auth/validate_token'

      expect(response).to have_http_status(:success)
    end
  end
end
