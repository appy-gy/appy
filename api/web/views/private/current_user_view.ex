defmodule Top.Private.CurrentUserView do
  use Top.Web, :view

  def render("show.json", %{user: nil}), do: %{user: nil}
  def render("show.json", %{user: user}) do
    %{user: Dict.put(render_one(user, Top.Private.UserView, "user.json"), :role, user.role)}
  end
end
