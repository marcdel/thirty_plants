defmodule ThirtyPlantsTest do
  use ThirtyPlants.DataCase, async: true

  import ThirtyPlants.AccountsFixtures

  alias ThirtyPlants.Log.Plant

  setup do
    {:ok, plant} = ThirtyPlants.Log.create_plant(%{name: "po-tay-to"})

    %{user: user_fixture(), tater: plant}
  end

  describe "start_week/1" do
    test "starts a new week for the given user", %{user: user} do
      assert {:error, nil} = ThirtyPlants.Log.current_week(user)

      {:ok, _} = ThirtyPlants.start_week(user)

      {:ok, week} = ThirtyPlants.Log.current_week(user)
      assert week.user_id == user.id
      assert week.start_date == Date.utc_today()
      assert week.end_date == Date.add(Date.utc_today(), 7)
    end
  end

  describe "add_plant/2" do
    test "adds the specified plant to the current week for the given user", %{
      user: user,
      tater: tater
    } do
      {:ok, week} = ThirtyPlants.start_week(user)

      {:ok, _} = ThirtyPlants.add_plant(user, tater)

      plants = ThirtyPlants.Log.list_week_plants(week)
      assert Enum.member?(plants, tater)
    end

    test "fails if there is no current week", %{user: user, tater: tater} do
      {:error, _} = ThirtyPlants.add_plant(user, tater)
    end
  end

  describe "current_plants/1" do
    test "lists all plants for the current week for the given user", %{user: user} do
      {:ok, _} = ThirtyPlants.start_week(user)

      {:ok, tater} = ThirtyPlants.Log.create_plant(%{name: "po-tay-to"})
      {:ok, tomato} = ThirtyPlants.Log.create_plant(%{name: "to-mah-to"})

      {:ok, _} = ThirtyPlants.add_plant(user, tater)
      {:ok, _} = ThirtyPlants.add_plant(user, tomato)

      plants = ThirtyPlants.current_plants(user)
      assert Enum.member?(plants, tater)
      assert Enum.member?(plants, tomato)
    end
  end

  describe "remove_plant/2" do
    test "removes the specified plant from the current week for the given user", %{
      user: user,
      tater: tater
    } do
      {:ok, _} = ThirtyPlants.start_week(user)
      {:ok, _} = ThirtyPlants.add_plant(user, tater)

      {:ok, _} = ThirtyPlants.remove_plant(user, tater)

      plants = ThirtyPlants.current_plants(user)
      refute Enum.member?(plants, tater)
    end

    test "fails if there is no current week", %{user: user, tater: tater} do
      {:error, _} = ThirtyPlants.remove_plant(user, tater)
    end

    test "fails if plant has not been added this week", %{user: user, tater: tater} do
      {:ok, _} = ThirtyPlants.start_week(user)
      {:error, _} = ThirtyPlants.remove_plant(user, tater)
    end

    test "fails if plant doesn't exist", %{user: user} do
      {:ok, _} = ThirtyPlants.start_week(user)
      {:error, _} = ThirtyPlants.remove_plant(user, %Plant{})
      {:error, _} = ThirtyPlants.remove_plant(user, nil)
    end
  end
end
