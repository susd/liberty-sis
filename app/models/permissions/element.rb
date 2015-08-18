module Permissions
  class Element
    include Comparable

    def rank
      raise "Not implemented"
    end
  end
end
