require 'rails_helper'

# RSpec.describe Product, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe Product, type: :model do

  subject {
    Product.new(
      name: 'Test',
      description: 'Product created for the tests',
      quantity: 2,
      price_cents: 10,
      image: nil
    )
  }

  describe 'Validations' do
    before :each do
      @category = Category.new
      @category.name = 'category name'
      @category.save
    end

    it 'should have all four fields' do
      subject.category = @category
      subject.save

      expect(subject).to be_valid
    end

    it 'should have a name' do
      subject.name = nil
      subject.category = @category
      subject.save

      expect(subject.errors.full_messages[0].downcase).to include('name')
    end

    it 'should have a price' do
      subject.price_cents = nil
      subject.category = @category
      subject.save

      expect(subject.errors.full_messages[0].downcase).to include('price cents')
    end

    it 'should have a quantity' do
      subject.quantity = nil
      subject.category = @category
      subject.save

      expect(subject.errors.full_messages[0].downcase).to include('quantity')
    end

    it 'should have a category' do
      subject.save

      expect(subject.errors.full_messages[0].downcase).to include('category')
    end
  end
end
