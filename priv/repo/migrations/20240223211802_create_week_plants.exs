defmodule ThirtyPlants.Repo.Migrations.CreateWeekPlants do
  use Ecto.Migration

  def change do
    create table(:week_plants) do
      add :week_id, references(:weeks, on_delete: :delete_all), null: false
      add :plant_id, references(:plants, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:week_plants, [:week_id])
    create index(:week_plants, [:plant_id])
    create unique_index(:week_plants, [:week_id, :plant_id])
  end
end
