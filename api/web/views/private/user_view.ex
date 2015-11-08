defmodule Top.Private.UserView do
  use Top.Web, :view

  alias Top.User

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      avatar: User.avatar_url(user),
      facebook_link: user.facebook_link,
      instagram_link: user.instagram_link,
      created_at: user.created_at,
      slug: user.slug}
  end
end
