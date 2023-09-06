if ActiveRecord::Base.connection.table_exists? 'gutentag_tags'
  model =  Object.const_get "Gutentag::Tag"
  model.singleton_class.class_eval do
    define_method(:ransackable_attributes) do |auth_object|
      auth_object = nil
      ['name']
    end
  end
end
