module Pearson
  module SuccessNet

    class Formatter
      BOM = "\xFF\xFE"

      def self.write(path, &block)
        File.open(path, 'w'){|f| f.write BOM}
        File.open(path, 'a', encoding: "UTF-16LE", &block)
      end
    end

  end
end
