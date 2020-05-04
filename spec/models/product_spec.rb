require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      @category = Category.new({name: "test"})
      @product = Product.new({name: "product", price: 15, quantity: 3, category: @category })
      expect(@product).to be_valid
    end
    it "isn't valid without a name" do
      @category = Category.new({name: "test"})
      @product = Product.new({ price: 15, quantity: 3, category: @category })
      expect(@product).to_not be_valid
    end
     it "isn't valid without a price" do
      @category = Category.new({name: "test"})
      @product = Product.new({name: "product", quantity: 3, category: @category })
      expect(@product).to_not be_valid
    end
     it "isn't valid without a quantity" do
      @category = Category.new({name: "test"})
      @product = Product.new({name: "product", price: 15, category: @category })
      expect(@product).to_not be_valid
    end
     it "isn't valid without a category" do
      @product = Product.new({name: "product", price: 15, quantity: 3 })
      expect(@product).to_not be_valid
    end
  end
end
