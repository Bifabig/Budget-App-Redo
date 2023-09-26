require_relative '../rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.new(name: 'Biftu', email: 'biftu@test.com', password: '123123') }
  subject { Group.new(name: 'Food', author: user) }

  before do
    subject.icon.attach(io: File.open(Rails.root.join('spec', 'models', 'files', 'test.png')), filename: 'test.png',
                        content_type: 'image/png')
    subject.save
  end

  describe 'test validations' do
    it { expect(subject).to be_valid }
  end

  describe 'test associations' do
    it { should belong_to(:author) }
    it { should have_and_belong_to_many(:entities) }
  end
end
