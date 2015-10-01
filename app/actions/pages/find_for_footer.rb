module Pages
  class FindForFooter
    const :slugs, %w{about ads}

    def call
      Page.where slug: slugs
    end
  end
end
