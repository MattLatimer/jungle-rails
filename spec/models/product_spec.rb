require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'Should be valid with all required fields' do
      @category = Category.create!({ name: 'c' })
      @product = Product.new({
        name: 'a',
        price: 1,
        quantity: 1,
        category_id: @category.id
      })
      expect(@product).to be_valid
    end

    it 'Should be not be valid missing a name' do
      @category = Category.create!({ name: 'c' })
      @product = Product.new({
        price: 1,
        quantity: 1,
        category_id: @category.id
      })
      expect(@product).to be_invalid
      expect(@product.errors[:name]).to include("can't be blank")
    end

    it 'Should be not be valid missing a price' do
      @category = Category.create!({ name: 'c' })
      @product = Product.new({
        name: 'a',
        quantity: 1,
        category_id: @category.id
      })
      expect(@product).to be_invalid
      expect(@product.errors[:price]).to include("can't be blank")
      expect(@product.errors[:price]).to include("is not a number")
    end

    it 'Should be not be valid missing a quantity' do
      @category = Category.create!({ name: 'c' })
      @product = Product.new({
        name: 'a',
        price: 1,
        category_id: @category.id
      })
      expect(@product).to be_invalid
      expect(@product.errors[:quantity]).to include("can't be blank")
      expect(@product.errors[:quantity]).to include("is not a number")
    end

    it 'Should be not be valid missing a category' do
      @product = Product.new({
        name: 'a',
        price: 1,
        quantity: 1,
      })
      expect(@product).to be_invalid
      expect(@product.errors[:category_id]).to include("can't be blank")
    end
  end
end
