class Module

  def create_finder_methods(*attributes)
    attributes.each do |attribute|
      class_eval %Q{
        def self.find_by_#{attribute}(argument)
          all = self.all()
          found_items = all.select{|item| item.#{attribute} == argument}
          if found_items.length > 0 
            return found_items[0]
          else
            return nil
          end
        end}
    end 
  end
end
