module Analogue
  class DataSlot
    CORE_SPECIFIC_FILE_MASK = 0b000000010
    INSTANCE_JSON_MASK = 0b000010000

    attr_reader :required, :parameters, :filename, :extensions

    def core_sepecific?
      @parameters & CORE_SPECIFIC_FILE_MASK != 0
    end

    def instance_json?
      @parameters & INSTANCE_JSON_MASK != 0
    end

    def initialize(data_slot)
      @required = data_slot.required

      parameters = data_slot.parameters
      @parameters = parameters.is_a?(String) ? parameters.to_i(16) : parameters

      @filename = data_slot.filename
      @extensions = data_slot.extensions
    end
  end
end
