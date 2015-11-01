Code.require_file "each_line.exs", __DIR__

defmodule Ionicons.FontGenerator do
  alias Ionicons.EachLine

  @tools ~W{fontforge sfnt2woff}
  @font_path "frontend/fonts/ionicons.woff"
  @styles_path "frontend/styles"
  @repo_path Path.join(__DIR__, "ionicons")
  @repo_url "git@github.com:driftyco/ionicons.git"
  @direct_icon_regex ~r/ion-icon\((?:(?:'|"))?(.*?)(?:(?:'|"))?\)/

  def generate do
    check_tools
    with_repo fn ->
      remove_unused_svgs(icons)
      build_font
      copy_font
    end
    :ok
  end

  defp check_tools do
    missing = Enum.reject @tools, &System.find_executable/1
    unless Enum.empty? missing do
      raise RuntimeError, message: "One or more of the required tools are missing: #{Enum.join missing, ", "}. Install them first"
    end
  end

  defp remove_unused_svgs(icons) do
    @repo_path
    |> Path.join("src/**/*.svg")
    |> Path.wildcard
    |> Enum.reject(&use_svg?(&1, icons))
    |> Enum.each(&File.rm!/1)
  end

  defp build_font do
    System.cmd "python", [Path.join(@repo_path, "builder/generate.py")]
  end

  defp copy_font do
    @repo_path
    |> Path.join("fonts/ionicons.woff")
    |> File.cp!(@font_path)
  end

  defp use_svg?(path, icons) do
    Set.member? icons, Path.basename(path, ".svg")
  end

  defp icons do
    lines = String.split styles, "\n"
    direct_icons(lines) ++ each_icons(lines)
    |> Enum.reduce(MapSet.new, &Set.put(&2, &1))
  end

  defp direct_icons(lines) do
    lines
    |> Enum.filter(&String.contains?(&1, "+ion-icon"))
    |> Enum.map(&Regex.run @direct_icon_regex, &1, capture: :all_but_first)
    |> Enum.map(&List.first/1)
    |> Enum.reject(&String.starts_with?(&1, "$"))
  end

  defp each_icons(lines) do
    lines
    |> Enum.filter(&String.contains?(&1, "@each"))
    |> Enum.flat_map(&EachLine.icons(&1))
  end

  defp styles do
    @styles_path
    |> Path.join("**/*.sass")
    |> Path.wildcard
    |> Enum.map(&File.read!/1)
    |> Enum.join("\n")
  end

  defp with_repo(fun) do
    clone_repo
    fun.()
    remove_repo
  end

  defp clone_repo do
    System.cmd "git", ~w{clone #{@repo_url} #{@repo_path}}
  end

  defp remove_repo do
    File.rm_rf! @repo_path
  end
end
