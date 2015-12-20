defmodule Top.SaveCallback do
  defmacro before_save(function, args \\ []) do
    quote do
      before_insert unquote(function), unquote(args)
      before_update unquote(function), unquote(args)
    end
  end

  defmacro before_save(module, function, args) do
    quote do
      before_insert unquote(module), unquote(function), unquote(args)
      before_update unquote(module), unquote(function), unquote(args)
    end
  end

  defmacro after_save(function, args \\ []) do
    quote do
      after_insert unquote(function), unquote(args)
      after_update unquote(function), unquote(args)
    end
  end

  defmacro after_save(module, function, args) do
    quote do
      after_insert unquote(module), unquote(function), unquote(args)
      after_update unquote(module), unquote(function), unquote(args)
    end
  end
end
