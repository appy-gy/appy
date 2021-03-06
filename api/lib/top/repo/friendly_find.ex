defmodule Top.FriendlyFind do
  @moduledoc """
  Adds two methods to the Repo module `find` and `find!`. Which attempts to
  find a record by both id and slug fields

  ## Example

      Repo.find User, id_or_slug
  """

  import Ecto.Query, only: [from: 2]

  defmacro __using__(_) do
    quote do
      def find(model, id) do
        one unquote(__MODULE__).build_query(model, id)
      end

      def find!(model, id) do
        one! unquote(__MODULE__).build_query(model, id)
      end
    end
  end

  def build_query(model, id) do
    query = if uuid? id do
      from r in model, where: r.id == ^id or r.slug == ^id
    else
      from r in model, where: r.slug == ^id
    end
    from r in query, limit: 1
  end

  defp uuid?(id) do
    Regex.match? ~r/\w{8}-\w{4}-\w{4}-\w{4}-\w{12}/, id
  end
end
