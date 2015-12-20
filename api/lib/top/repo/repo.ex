defmodule Top.Repo do
  use Ecto.Repo, otp_app: :top
  use Scrivener
  use Top.FriendlyFind
end
