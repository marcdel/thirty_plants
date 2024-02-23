defmodule ThirtyPlants.Log.WeekPlant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "week_plants" do
    field :week_id, :id
    field :plant_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(week_plant, attrs) do
    week_plant
    |> cast(attrs, [:week_id, :plant_id])
    |> foreign_key_constraint(:week_id)
    |> foreign_key_constraint(:plant_id)
    |> validate_required([:week_id, :plant_id])
  end
end
