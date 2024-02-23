defmodule ThirtyPlants.LogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ThirtyPlants.Log` context.
  """

  @doc """
  Generate a plant.
  """
  def plant_fixture(attrs \\ %{}) do
    {:ok, plant} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> ThirtyPlants.Log.create_plant()

    plant
  end

  import ThirtyPlants.AccountsFixtures

  @doc """
  Generate a week.
  """
  def week_fixture(attrs \\ %{}) do
    user = user_fixture()

    attrs =
      Enum.into(attrs, %{
        end_date: ~D[2024-02-22],
        start_date: ~D[2024-02-22]
      })

    {:ok, week} = ThirtyPlants.Log.create_week(user, attrs)

    week
  end

  @doc """
  Generate a week_plant.
  """
  def week_plant_fixture(attrs \\ %{}) do
    week = week_fixture()
    plant = plant_fixture()

    {:ok, week_plant} =
      attrs
      |> Enum.into(%{
        week_id: week.id,
        plant_id: plant.id
      })
      |> ThirtyPlants.Log.create_week_plant()

    week_plant
  end
end
