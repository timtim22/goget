require 'rails_helper'
RSpec.describe Job, type: :model do

 it { should validate_presence_of(:pickup_address)}
 it { should validate_presence_of(:pick_lat)}
 it { should validate_presence_of(:pick_lng)}
 it { should validate_presence_of(:drop_address)}
 it { should validate_presence_of(:drop_lat)}
 it { should validate_presence_of(:drop_lng)}

 describe 'Associations' do
   it { should belong_to(:user) }
 end
end