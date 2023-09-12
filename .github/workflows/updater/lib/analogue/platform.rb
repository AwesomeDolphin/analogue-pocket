module Analogue
  class Platform
    attr_reader :category, :name, :manufacturer, :year

    def initialize(definition)
      @category = definition.platform.category
      @name = definition.platform.name
      @manufacturer = definition.platform.manufacturer
      @year = definition.platform.year
    end
  end
end
