module EnumI18n
  class Railtie < Rails::Railtie
    initializer "enum_i18n.i18n" do
      ActiveRecord::Base.send :extend, EnumI18n::I18n
    end
  end
end
