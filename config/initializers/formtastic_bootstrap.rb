require 'rails3-jquery-autocomplete'

module FormtasticBootstrap
  module Inputs
    class AutocompleteInput < Formtastic::Inputs::AutocompleteInput
      include Base

      def to_html
        bootstrap_wrapping do
          builder.autocomplete_field(method, options.delete(:url), input_html_options)
        end
      end
    end
  end
end
