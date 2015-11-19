defmodule Top.TagIndex do
  @index "tags"

  use Top.Web, :index

  define type: "tag" do
    indexes "name", type: "string"
  end

  def query(term) do
    tags = search index: index_name do
      query do
        prefix "name", term
      end
    end

    tags |> Query.create_resource |> load
  end
end
