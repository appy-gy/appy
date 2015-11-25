defmodule Top.ImageProcessor do
  import Mogrify

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

    Enum.each opts[:versions], fn {name, {width, height}} ->
      Enum.each opts[:sizes], fn size ->
        version_name = "#{name}_#{size}x"
        process_version source, Path.join(dest, "#{version_name}_#{filename}"), width, height, opts
      end
    end
  end

  defp process_version(source, dest, width, height, opts) do
    image = source |> open |> copy |> background(opts[:pad_color])
    image = apply Mogrify, opts[:resize], [image, "#{width}x#{height} -gravity Center"]
    image |> format("jpg") |> mozjpeg(opts[:quality]) |> save(dest)
  end

  defp strip(image) do
    {_, 0} = run image.path, "strip"
    image |> verbose
  end

  defp background(image, pad_color) do
    {_, 0} = run image.path, "background", pad_color
    image |> verbose
  end

  defp mozjpeg(image, quality) when @use_mozjpeg do
    tmp_path = image.path <> "tmp"
    File.cp! image.path, tmp_path
    System.cmd @cjpeg_path, ~w{-quality #{quality} -outfile #{image.path} #{tmp_path}}, stderr_to_stdout: true
    image |> verbose
  end
  defp mozjpeg(image), do: image
end
