class Module

  def create_finder_methods(*attributes)
    attributes.each do |attribute|
      class_eval %Q{
        def self.find_by_#{attribute}(argument)
          all = self.all()
          found = all.select{|item| item.#{attribute} == argument}
          if found.length > 0 
            return found[0]
          else
            return nil
          end
        end}
    end 
  end
end
