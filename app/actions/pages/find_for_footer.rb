module Pages
  class FindForFooter
    const :slugs, %w{about advertising}

    def call
      Page.where slug: slugs
    end
  end
end
