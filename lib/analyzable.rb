module Analyzable

  def average_price(products)
    (products.inject(0){|sum, product| sum + product.price.to_f}/products.size).round(2)
  end

  def print_report(argument)
      report = "Average price of products: $#{average_price(argument)} \n"
      count_by_brand(argument).each do |brand, count| 
        report << "Number of products for #{brand} brand: #{count} \n" 
      end
      count_by_name(argument).each do |name, count|
        report << "Number of products named #{name}: #{count} \n" 
      end
      report << "Lowest price: $#{lowest_price(argument)} \n"
      return report 
  end
  
  def count_by_brand(products)
    brands = products.map {|p| p.brand} 
    count_by_attribute(brands)
  end
  
  def count_by_name(products)
    names = products.map {|p| p.name}
    count_by_attribute(names)
  end
  
  def count_by_attribute(attribute)
    attribute_hash = attribute.inject(Hash.new(0)) {|result, element| result[element] += 1 ;result}
    attribute_hash
  end
  
  #NEW FEATURE
  def lowest_price(products)
    product_prices = []
    products.each do |product|
      product_prices << product.price.to_f
    end
    product_prices.sort.first
  end
  
end


