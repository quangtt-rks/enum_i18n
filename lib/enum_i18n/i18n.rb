module EnumI18n
  module I18n
    # overwrite the enum method
    def enum( definitions )
      super( definitions )
      definitions.each do |name, _|
        Helper.define_attr_i18n_method(self, name)
        Helper.define_collection_i18n_method(self, name)
      end
    end

    def self.extended(receiver)
      # receiver.class_eval do
      #   # alias_method_chain :enum, :enum_help
      # end
    end
  end

  module Helper
    def self.define_attr_i18n_method(klass, attr_name)
      attr_i18n_method_name = "#{attr_name}_i18n"

      klass.class_eval <<-METHOD, __FILE__, __LINE__
      def #{attr_i18n_method_name}
        enum_symbol = self.send(:#{attr_name})
        if enum_symbol
          ::EnumHelp::Helper.translate_enum_symbol(self.class, :#{attr_name}, enum_symbol)
        else
          nil
        end
      end
      METHOD
    end

    def self.define_collection_i18n_method(klass, attr_name)
      collection_method_name = "#{attr_name.to_s.pluralize}"
      collection_i18n_method_name = "#{collection_method_name}_i18n"

      klass.instance_eval <<-METHOD, __FILE__, __LINE__
      def #{collection_i18n_method_name}
        collection_array = #{collection_method_name}.collect do |symbol, _|
          [symbol, ::EnumHelp::Helper.translate_enum_symbol(self, :#{attr_name}, symbol)]
        end
        Hash[collection_array].with_indifferent_access
      end
      METHOD
    end

    def self.translate_enum_symbol(klass, attr_name, enum_symbol)
      ::I18n.t("activerecord.attributes.#{klass.to_s.underscore.gsub('/', '.')}.#{attr_name.to_s.pluralize}.#{enum_symbol}", default: enum_symbol.humanize)
    end
  end
end
