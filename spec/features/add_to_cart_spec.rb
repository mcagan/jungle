require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    @user = User.create!({name: "Michelle", email: "test@test.com", password: "StrongPassword123", password_confirmation: "StrongPassword123"})
  end

  scenario "They can add items to the cart" do

    # ACT
    visit root_path
    expect(page).to have_text(@category.products.first.name)
    expect(page).to have_text "My Cart (0)"
    click_on 'Login'
    find('#email').set('test@test.com')
    find('#password').set('StrongPassword123')
    click_button 'Submit'

    click_on('Add')
    puts page.html

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_text "My Cart (1)"
  end
end
