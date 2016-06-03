class Module
  def self.create_finder_methods(*attributes)
    attributes.each do |attribute|
      define_find_by(attribute)
    end 
  end
      
  def define_find_by(attribute)
    define_method("find_by_#{attribute}") do |argument|
      all.each do |item|
        return item if item.send(attribute) == argument
      end
    end
  end
end
