require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Biftu') }
  before { subject.save }

  describe 'test for validations' do
    it { should allow_value('Biftu').for(:name) }
  end

  describe 'test for associations' do
    it { should have_many(:groups) }
    it { should have_many(:entities) }
  end
end
