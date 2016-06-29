module NameCreatable

  extend ActiveSupport::Concern

  module ClassMethods

    def find_or_create_by_lowercase_name!(name)
      name.strip!
      instance = self.where('lower(name) = ?', name.downcase).first
      if instance.nil?
        instance = self.create! name: name
      end
      instance
    end
  end

end
