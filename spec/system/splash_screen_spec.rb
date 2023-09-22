require_relative '../rails_helper'

RSpec.describe 'Splash Screen', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'show splash screen' do
    visit '/'
    expect(page).to have_content('Budget App')
  end

  it 'show sign up button' do
    visit '/'
    expect(page).to have_link('SIGN UP')
  end

  it 'show log in button' do
    visit '/'
    expect(page).to have_link('LOG IN')
  end
end
