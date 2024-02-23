defmodule ThirtyPlants.Repo.Migrations.CreateWeeks do
  use Ecto.Migration

  def change do
    create table(:weeks) do
      add :start_date, :date, null: false
      add :end_date, :date, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:weeks, [:user_id])
  end
end
