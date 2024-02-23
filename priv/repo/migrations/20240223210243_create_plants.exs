defmodule ThirtyPlants.Repo.Migrations.CreatePlants do
  use Ecto.Migration

  def change do
    create table(:plants) do
      add :name, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
