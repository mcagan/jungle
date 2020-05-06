require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can visit a product detail page" do
    p = Product.all.sample
    # ACT
    visit root_path
    expect(page).to have_text(p.name)
    link = page.find(:xpath, ".//a[@href='/products/#{p.id}']", text: p.name)
    link.trigger('click')

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_selector 'section.products-show'
    expect(page).to have_text p.name
  end
end