defmodule Ionicons.EachLine do
  def icons(line) do
    [variables, values] = String.split line, " in "
    case find_icon_position variables do
      nil -> []
      icon_position ->
        values |> to_lists |> Enum.map(&get_icon(&1, icon_position))
    end
  end

  defp find_icon_position(variables) do
    Regex.scan(~r/\$[-\w]+/, variables)
    |> Enum.map(&List.first/1)
    |> Enum.find_index(&(&1 == "$icon"))
  end

  defp to_lists(values) do
    Regex.scan(~r/\((.*?)\)/, values, capture: :all_but_first)
    |> Enum.map(&List.first/1)
  end

  defp get_icon(list, icon_position) do
    list
    |> String.split(~r/[\s,]+/)
    |> Enum.at(icon_position)
  end
end
