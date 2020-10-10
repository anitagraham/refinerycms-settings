module ::Refinery
  module Admin
    module SettingsHelper
      def form_value_type
        @setting.form_value_type.presence || 'text_area'
      end

      def setting_title(f)
        if @setting.form_value_type == 'check_box'
          raw "<h3>#{@setting.name.to_s.titleize}?</h3>"
        else
          f.label :value
        end
      end

      def setting_field(f, help)
        case form_value_type
          when 'check_box'
            raw "#{f.check_box :value, :value => @setting.form_value}
                #{f.label :value, help.presence || t('enabled', :scope => 'refinery.admin.settings.form'),
                          :class => 'stripped'}"
          else
            f.text_area :value, :value => @setting.form_value,
                        :class => 'widest', :rows => 5
        end
      end

      def filter_form_fields(field)
        attribute_values = filter_values(field)
        return if attribute_values.empty? || !attribute_values

        legend = tag.legend t('filter_by', field_name: field.capitalize, scope: 'refinery.admin.settings.filters')
        radio_buttons = attribute_values.each.reduce(ActiveSupport::SafeBuffer.new) do |buffer, value|
          buffer << button_and_label(field, value)
        end
        tag.fieldset do
          legend << tag.div(radio_buttons, class: :field)
        end
      end

      private
        def filter_values(filter_name)
          case filter_name
            when :scoping
              @scopings
            when :restricted
              [true, false]
            else
              false
          end
        end

        def button_and_label(field, value)
          button_label = label_tag "filter_#{field}", value.to_s.capitalize
          button = radio_button_tag "filter[#{field}]", value.to_s
          tag.div class: :radio_button do
             button << button_label
          end
        end
    end
  end
end
