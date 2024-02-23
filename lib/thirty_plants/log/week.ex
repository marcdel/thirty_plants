defmodule ThirtyPlants.Log.Week do
  use Ecto.Schema
  import Ecto.Changeset

  schema "weeks" do
    field :start_date, :date
    field :end_date, :date
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(week, attrs) do
    week
    |> cast(attrs, [:user_id, :start_date, :end_date])
    |> foreign_key_constraint(:user_id)
    |> validate_required([:user_id, :start_date, :end_date])
  end
end
