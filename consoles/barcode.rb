module Barcode
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances ||= {}
    end

    def find(code)
      instances[code]
    end
  end

  module InstanceMethods
    def add_barcode(code)
      if code =~ /^[a-z]+\w.+\d{3}$/i
        self.barcode = code
        self.class.instances[code] = self
      else
        raise "Barcode has invalid format"
      end
    end
  end
end
