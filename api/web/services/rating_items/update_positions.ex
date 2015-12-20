defmodule Top.RatingItems.UpdatePositions do
  def call(positions) do
    Ecto.Adapters.SQL.query Top.Repo, query(positions), params(positions)
  end

  defp query(positions) do
    """
    UPDATE "rating_items" as t
    SET "position" = v."position"
    FROM (values #{values_part(positions)}) as v("id", "position")
    WHERE t."id" = v."id"::uuid;
    """
  end

  defp values_part(positions) do
    1..Dict.size(positions)
    |> Enum.map_join(", ", &("($#{2 * &1 - 1}, $#{2 * &1}::integer)"))
  end

  def params(positions) do
    Enum.flat_map positions, fn({id, position}) -> [id, position] end
  end
end
