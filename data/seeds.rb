require 'faker'
require_relative '../lib/product'

def db_seed
  10.times do
    Product.create(brand: Faker::Company.name,
                   name: Faker::Commerce.product_name,
                   price: Faker::Commerce.price)
  end
end
