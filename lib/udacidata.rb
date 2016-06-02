require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

@@data_path = File.dirname(__FILE__) + "/../data/data.csv"

create_finder_methods(:brand, :name) 

  def self.create(attributes = nil)
      if attributes[:id]
          id = attributes[:id].to_i
          item = find(id)
          return item unless item == nil 
      end
      item = self.new
      self.save(item)
      return item
  end
  
  def self.save(item)
      CSV.open(@@data_path, "ab") do |csv|
        csv << ["#{item.id}", "#{item.brand}", "#{item.name}", "#{item.price}"]
    end
  end
  
  def self.all
      #return an array of the objects representing all the data in the database.
      all = CSV.read(@@data_path).drop(1)
      all.each_with_object([]) do |row, item|
        item << Product.new(id: row[0], brand: row[1], name: row[2], price: row[3].to_i)
      end
  end
  
  def self.first(n = nil)      
      #will return an array of objects for the first n products in the database.
      n ? all.take(n) : all.first 
  end
  
  def self.last(n = nil)
      #will return an array of objects for the last n products in the database.
      n ? all.take(n) : all.last
  end
  
  def self.find(n) 
      #should return an object for the product with a given product id.
      all.each do |item|
        if item.id == n 
          return item
        end
      end
      raise ProductNotFoundError, "The id number you entered does not match a product in the database."
  end

  def self.destroy(n) 
    deleted_item = self.find(n)
    new_array = self.all()
    new_array.delete_if{|item| item.id == n }
    self.rewrite_csv(new_array)
    return deleted_item
  end
  
  def self.rewrite_csv(new_array)
      CSV.open(@@data_path + ".tmp", "wb") do |csv|
        csv << ["id", "brand", "name", "price"]
        new_array.each do |item|
          csv << ["#{item.id}", "#{item.brand}", "#{item.name}", "#{item.price}"]
        end
        File.rename(@@data_path + ".tmp", @@data_path)
      end
  end
  
  def self.where 
      #should return an array of Product objects that match a given brand or product name.
  end
  
#   def #product_instance.update ? 
#       #should change the information for a given Product object, and save the new data to the database.
#   end 

end
