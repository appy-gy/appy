module IdAsSlug
  extend ActiveSupport::Concern

  included do
    before_validation :set_fake_slug, on: :create
    after_create :set_id_as_slug
  end

  private

  def set_fake_slug
    self.slug = SecureRandom.uuid
  end

  def set_id_as_slug
    self.slug = id
  end

  def uuid? str
    str =~ /\A\h{8}-(\h{4}-){3}\h{12}\z/
  end
end
