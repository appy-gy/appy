defmodule Top.ClientError do
  use Top.Web, :model

  schema "client_errors" do
    field :info, :map, default: %{}
    timestamps inserted_at: :created_at
  end

  @required_fields ~W(info)
  @optional_fields ~W()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
