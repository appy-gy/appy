defmodule Top.ImageProcessor do
  @default_opts [
    versions: [],
    sizes: [1, 2],
    quality: 80,
    resize: :resize_to_fill,
    pad_color: "white"
  ]

  @use_mozjpeg Application.get_env(:top, __MODULE__)[:use_mozjpeg]
  @cjpeg_path Application.get_env(:top, __MODULE__)[:cjpeg_path]

  def process(source, dest, filename, opts) do
    opts = Dict.merge @default_opts, opts

    tasks = Enum.flat_map opts[:versions], fn {name, {width, height}} ->
      Enum.map opts[:sizes], fn size ->
        version_name = "#{name}_#{size}x"
        Task.async fn ->
          process_version source, Path.join(dest, "#{version_name}_#{filename}"), width, height, opts
        end
      end
    end

    Enum.each tasks, &(Task.await(&1, 30000))
  end

  defp process_version(source, dest, width, height, opts) do
    image = source
    |> open
    |> copy
    |> convert(width: width, height: height, resize: opts[:resize], pad_color: opts[:pad_color])
    |> mozjpeg(opts[:quality])
    |> move(dest)
  end

  def open(path) do
    {info, 0} = System.cmd "identify", [path]
    [width, height] = ~r/(\d+)x(\d+)/
    |> Regex.run(info, capture: :all_but_first)
    |> Enum.map(&(&1 |> Integer.parse |> elem(0)))
    %{path: path, width: width, height: height}
  end

  defp copy(image) do
    name = Path.basename image.path
    number = :crypto.rand_uniform 100000, 999999
    new_path = Path.join System.tmp_dir, "#{number}-#{name}"
    File.cp! image.path, new_path
    %{image | path: new_path}
  end

  defp move(image, dest) do
    File.cp! image.path, dest
    File.rm! image.path
    %{image | path: dest}
  end

  defp convert(image, width: width, height: height, resize: resize, pad_color: pad_color) do
    new_path = String.replace_suffix image.path, Path.extname(image.path), ".jpg"
    args = ~w(-strip -format jpg -quality 100 -background #{pad_color} -alpha remove -resize #{resize_arg image, resize, width, height} -gravity Center #{image.path} #{new_path})
    System.cmd "convert", args
    if image.path <> new_path, do: File.rm!(image.path)
    %{image | path: new_path}
  end

  defp mozjpeg(image, quality) when @use_mozjpeg do
    image_copy = copy image
    System.cmd @cjpeg_path, ~w(-quality #{quality} -outfile #{image.path} #{image_copy.path})
    File.rm! image_copy.path
    image
  end
  defp mozjpeg(image, _), do: image

  defp resize_arg(_, :resize_to_limit, width, height) do
    arg = [width, height] |> Enum.reject(&is_nil/1) |> Enum.join("x")
    arg <> ">"
  end

  defp resize_arg(image, :resize_to_fill, width, height) do
    scale_x = width / image.width
    scale_y = height / image.height
    if scale_x >= scale_y do
      "#{(scale_x * (image.width + 0.5)) |> Float.round}"
    else
      "x#{(scale_y * (image.height + 0.5)) |> Float.round}"
    end
  end
end
