require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.new(name: 'biftu', email: 'biftu@example.com', password: 'password') }
  subject { Group.new(name: 'G1', author: user) }
  before do
    subject.icon.attach(io: File.open(Rails.root.join('spec', 'models', 'files', 'test.png')), filename: 'test.png',
                        content_type: 'image/png')
    subject.save
  end

  describe 'test validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'test associations' do
    it { should belong_to(:author) }
    it { should have_and_belong_to_many(:entities) }
  end
end
