require 'rails_helper'

RSpec.describe Entity, type: :model do
  let(:user) { User.new(name: 'biftu', email: 'biftu@example.com', password: 'password') }
  subject { Entity.new(name: 'E1', amount: 50, author: user) }
  before { subject.save }

  describe 'test validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:amount) }
  end

  describe 'test associations' do
    it { should belong_to(:author) }
    it { should have_and_belong_to_many(:groups) }
  end
end
