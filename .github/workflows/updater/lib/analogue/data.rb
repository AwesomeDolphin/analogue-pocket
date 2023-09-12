require_relative 'data_slot'

module Analogue
  class Data
    attr_reader :data_slots

    def initialize(definition)
      @data_slots = definition.data.data_slots.map do |data_slot|
        DataSlot.new(data_slot)
      end
    end
  end
end
