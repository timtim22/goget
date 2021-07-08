require 'rails_helper'

RSpec.describe AuthenticateUser do
  # create test user
  let!(:user) {FactoryBot.create(:poster)}
  subject(:valid_auth_obj) { described_class.new(user.email, user.password)}
  
  describe '#call' do
    # return token when valid request
    context 'when valid credentials' do
      it 'returns an auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end
  end
end