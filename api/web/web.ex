defmodule Top.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Top.Web, :controller
      use Top.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Model
      use Top.ModelName

      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]

      @primary_key {:id, Ecto.UUID, autogenerate: true}
      @foreign_key_type Ecto.UUID
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias Top.Repo
      import Ecto.Model
      import Ecto.Query, only: [from: 1, from: 2]

      import Top.Router.Helpers
      import Top.FetchCurrentUser
      import Top.SendError
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      import Top.Router.Helpers
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Top.Repo
      import Ecto.Model
      import Ecto.Query, only: [from: 1, from: 2]
    end
  end

  def index do
    quote do
      use Top.Index

      import Tirexs.Search
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end