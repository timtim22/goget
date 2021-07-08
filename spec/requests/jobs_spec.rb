require 'rails_helper'

RSpec.describe 'Job', type: :request do
  describe 'POST /jobs' do

    let!(:user) {FactoryBot.create(:poster)}

    let(:headers) do 
    {
      "Authorization" => JsonWebToken.encode(user_id: user.id),
      "Content-Type" => "application/json"
    }
    end
    
    let(:valid_credentials) do
      {
        pickup_address: Faker::Address.street_address,
        pick_lat: Faker::Number.number(digits: 2),
        pick_lng: Faker::Number.number(digits: 2),
        drop_address: Faker::Address.street_address,
        drop_lat: Faker::Number.number(digits: 2),
        drop_lng: Faker::Number.number(digits: 2),
        user_id: user.id
      }.to_json
    end

    context 'When request is valid' do
      before { post '/jobs', params: valid_credentials, headers: headers}
      it 'returns true' do
        expect(JSON.parse(response.body)["success"]).to eq(true)
      end
    end
  end
end