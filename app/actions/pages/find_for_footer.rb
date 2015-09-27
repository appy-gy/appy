module Pages
  class FindForFooter
    const :slugs, %w{about ads blog flow}

    def call
      Page.where slug: slugs
    end
  end
end
