require_relative '../rails_helper'

RSpec.describe EntitiesController, type: :system do
  let(:user) { User.create(name: 'Biftu', email: 'biftu@test.com', password: '123123', confirmed_at: Time.now) }

  before do
    driven_by(:rack_test)

    create_test_data(user)

    login_user(user)
  end

  after do
    clean_up_test_data
  end

  it 'can create a new entity' do
    visit group_path(Group.first)
    click_on 'Add Transaction'

    fill_in 'entity_name', with: 'Food'
    fill_in 'entity_amount', with: 234
    click_on 'Create Entity'

    expect(page).to have_content 'Food'
    expect(page).to have_content '234'
  end

  it 'can create a new entity with different groups' do
    visit group_path(Group.first)
    click_on 'Add Transaction'

    fill_in 'entity_name', with: 'Beverage'
    fill_in 'entity_amount', with: 123
    select Group.second.name, from: 'entity_group_ids_'
    click_on 'Create Entity'

    expect(page).to have_content 'Beverage'
    expect(page).to have_content '123'
  end

  private

  def create_test_data(user)
    5.times do |i|
      group = Group.create(name: "Group #{i}", author: user)
      group.icon.attach(io: File.open(Rails.root.join('spec', 'models', 'files', 'test.png')), filename: 'test.png',
                        content_type: 'image/png')
      group.save

      5.times do |j|
        entity = Entity.create(name: "Entity #{j}", amount: 100, author: user)
        entity.save
      end
    end

    Group.all.each do |group|
      group.entities << Entity.all.sample(rand(1..3))
    end

    Entity.all.each do |entity|
      entity.groups << Group.all.sample(rand(1..3))
    end
  end

  def login_user(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end

  def clean_up_test_data
    Group.destroy_all
    Entity.destroy_all
    User.destroy_all
  end
end
