require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /auth/login' do

    let!(:user) {FactoryBot.create(:poster)}
    
    let(:headers) do 
    {
      "Authorization" => JsonWebToken.encode(user_id: user.id),
      "Content-Type" => "application/json"
    }
    end

    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end

    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    context 'When request is valid' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        expect(JSON.parse(response.body)["message"]).not_to be_nil
      end
    end

    context 'When request is invalid' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(JSON.parse(response.body)["message"]).to eq('Invalid credentials')
      end
    end
  end
end