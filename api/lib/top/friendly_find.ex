defmodule Top.FriendlyFind do
  import Ecto.Query, only: [from: 2]

  alias Top.Repo

  def find(model, id) do
    Repo.one build_query(model, id)
  end

  def find!(model, id) do
    Repo.one! build_query(model, id)
  end

  defp build_query(model, id) do
    from r in model, where: r.id == ^id or r.slug == ^id, limit: 1
  end
end
