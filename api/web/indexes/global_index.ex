defmodule Top.GlobalIndex do
  @index "global"

  use Top.Web, :index

  @slop 20
  @max_expansions 10

  define type: "rating" do
    indexes "title", type: "string"
  end

  define type: "user" do
    indexes "name", type: "string"
  end

  def query(term) do
    items = [index: index_name, search: [query: [match_phrase_prefix: [_all: [query: term, slop: @slop, max_expansions: @max_expansions]]]]]
    load items
  end
end
