defmodule Top.Private.UserView do
  use Top.Web, :view

  alias Top.User

  def render("show.json", %{user: user, counts: counts}) do
    %{user: render_one(user, __MODULE__, "user_for_profile.json", counts: counts)}
  end

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

  def render("user_for_profile.json", %{user: user, counts: counts}) do
    Dict.merge render("user.json", %{user: user}), %{
      background: User.background_url(user),
      ratings_count: counts.ratings,
      comments_count: counts.comments
    }
  end

  def render("user_for_comment.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      avatar: User.avatar_url(user),
      slug: user.slug}
  end
end
