# app/models/concerns/filterable.rb
# https://gist.github.com/justinweiss/9065666
#

module Filterable
  extend ActiveSupport::Concern

  mattr_accessor :filters

  class_methods do

    def filter_by(filtering_params)
      results = self.all
      filtering_params.each do |key, value|
        results = results.public_send("filter_by_#{key}", value) if value.present?
      end
      results
    end

  end
end
