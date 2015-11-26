defmodule Top.Password do
  import Ecto.Changeset, only: [fetch_change: 2, put_change: 3, delete_change: 2]

  alias Comeonin.Bcrypt

  def update_password(changeset) do
    case fetch_change(changeset, :password) do
      {:ok, password} ->
        {hash, salt} = hash password
        changeset |> put_change(:crypted_password, hash) |> put_change(:salt, salt)
      :error -> delete_change changeset, :password
    end
  end

  def hash(password) do
    salt = Bcrypt.gen_salt
    {hash, 0} = System.cmd "ruby", ["-rbcrypt", "-e", "puts BCrypt::Password.create(ARGV[0])", password <> salt]
    {String.rstrip(hash), salt}
  end

  def valid?(password, hash, salt) do
    Bcrypt.checkpw password <> salt, hash
  end
end
