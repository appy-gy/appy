module Sections
  class FindForHeader
    def call
      Section.order :position
    end
  end
end
