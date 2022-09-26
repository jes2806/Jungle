require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is not valid with nil name" do
      @category = Category.create(name: "plants")
      @product = @category.products.create(name: "fern", quantity: 3, price_cents: 1000)
      @product.name = nil
      expect(@product).to_not be_valid
    end

    it "is not valid with no price" do
      @category = Category.create(name: "plants")
      @product = @category.products.create(name: "willow", quantity: 2, price_cents: 10000)
      @product.price_cents = nil
      expect(@product).to_not be_valid
    end

    it "is not valid with nil quantity" do
      @category = Category.create(name: "plants")
      @product = @category.products.create(name: "flower", quantity: 100, price_cents: 400)
      @product.quantity = nil
      expect(@product).to_not be_valid
    end

    it "is invalid with nil category" do
      @category = Category.create(name: "plants")
      @product = @category.products.create(name: "aloe", quantity: 50, price_cents: 2000)
      @product.category = nil
      expect(@product).to_not be_valid
    end

    it "is valid with valid inputs" do
      @category = Category.create(name: "plants")
      @product = @category.products.create(name: "rose", quantity: 10000, price_cents: 300)
      expect(@product).to be_valid
    end
    
  end
end
