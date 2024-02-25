defmodule ThirtyPlants.LogTest do
  use ThirtyPlants.DataCase, async: true

  alias ThirtyPlants.Log

  describe "plants" do
    alias ThirtyPlants.Log.Plant

    import ThirtyPlants.LogFixtures

    @invalid_attrs %{name: nil}

    test "list_plants/0 returns all plants" do
      plant = plant_fixture()
      assert Log.list_plants() == [plant]
    end

    test "get_plant!/1 returns the plant with given id" do
      plant = plant_fixture()
      assert Log.get_plant!(plant.id) == plant
    end

    test "create_plant/1 with valid data creates a plant" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Plant{} = plant} = Log.create_plant(valid_attrs)
      assert plant.name == "some name"
    end

    test "create_plant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Log.create_plant(@invalid_attrs)
    end

    test "update_plant/2 with valid data updates the plant" do
      plant = plant_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Plant{} = plant} = Log.update_plant(plant, update_attrs)
      assert plant.name == "some updated name"
    end

    test "update_plant/2 with invalid data returns error changeset" do
      plant = plant_fixture()
      assert {:error, %Ecto.Changeset{}} = Log.update_plant(plant, @invalid_attrs)
      assert plant == Log.get_plant!(plant.id)
    end

    test "delete_plant/1 deletes the plant" do
      plant = plant_fixture()
      assert {:ok, %Plant{}} = Log.delete_plant(plant)
      assert_raise Ecto.NoResultsError, fn -> Log.get_plant!(plant.id) end
    end

    test "change_plant/1 returns a plant changeset" do
      plant = plant_fixture()
      assert %Ecto.Changeset{} = Log.change_plant(plant)
    end
  end

  describe "weeks" do
    alias ThirtyPlants.Accounts.User
    alias ThirtyPlants.Log.Week

    import ThirtyPlants.AccountsFixtures
    import ThirtyPlants.LogFixtures

    @invalid_attrs %{start_date: nil, end_date: nil}

    setup do
      %{user: user_fixture()}
    end

    test "list_weeks/0 returns all weeks" do
      week = week_fixture()
      assert Log.list_weeks() == [week]
    end

    test "get_week!/1 returns the week with given id" do
      week = week_fixture()
      assert Log.get_week!(week.id) == week
    end

    test "current_week/1 returns the current week for the given user", %{user: user} do
      assert {:error, nil} = Log.current_week(user)

      attrs = %{
        start_date: Date.add(Date.utc_today(), -7),
        end_date: Date.utc_today()
      }

      assert {:ok, old_week} = Log.create_week(user, attrs)
      assert {:ok, ^old_week} = Log.current_week(user)

      assert {:ok, current_week} = Log.create_week(user)
      assert {:ok, ^current_week} = Log.current_week(user)
    end

    test "create_week/1 with valid data creates a week", %{user: user} do
      start_date = Date.utc_today()
      end_date = Date.add(start_date, 7)

      assert {:ok, %Week{} = week} = Log.create_week(user)
      assert week.start_date == start_date
      assert week.end_date == end_date
    end

    test "create_week/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Log.create_week(%User{}, @invalid_attrs)
    end

    test "delete_week/1 deletes the week" do
      week = week_fixture()
      assert {:ok, %Week{}} = Log.delete_week(week)
      assert_raise Ecto.NoResultsError, fn -> Log.get_week!(week.id) end
    end

    test "change_week/1 returns a week changeset" do
      week = week_fixture()
      assert %Ecto.Changeset{} = Log.change_week(week)
    end
  end

  describe "week_plants" do
    alias ThirtyPlants.Log.WeekPlant

    import ThirtyPlants.LogFixtures

    @invalid_attrs %{}

    test "list_week_plants/0 returns all week_plants" do
      %{week_id: week_id, plant_id: plant_id} = week_plant_fixture()
      assert [%{id: ^plant_id}] = Log.list_week_plants(%{id: week_id})
    end

    test "get_week_plant!/1 returns the week_plant with given id" do
      week_plant = week_plant_fixture()
      assert Log.get_week_plant!(week_plant.id) == week_plant
    end

    test "create_week_plant/1 with valid data creates a week_plant" do
      week = week_fixture()
      plant = plant_fixture()

      valid_attrs = %{week_id: week.id, plant_id: plant.id}

      assert {:ok, %WeekPlant{} = week_plant} = Log.create_week_plant(valid_attrs)

      assert week_plant.week_id == week.id
      assert week_plant.plant_id == plant.id
    end

    test "create_week_plant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Log.create_week_plant(@invalid_attrs)
    end

    test "add_plant_to_week/2 adds a plant to the given week" do
      week = week_fixture()
      plant = plant_fixture()

      assert {:ok, week_plant} = Log.add_plant_to_week(week, plant)

      assert week_plant.week_id == week.id
      assert week_plant.plant_id == plant.id
    end

    test "add_plant_to_week/2 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Log.add_plant_to_week(nil, nil)
    end

    test "delete_week_plant/1 deletes the week_plant" do
      week_plant = week_plant_fixture()
      assert {:ok, %WeekPlant{}} = Log.delete_week_plant(week_plant)
      assert_raise Ecto.NoResultsError, fn -> Log.get_week_plant!(week_plant.id) end
    end

    test "remove_plant_from_week/2 adds a plant to the given week" do
      week = week_fixture()
      plant = plant_fixture()
      assert {:ok, _} = Log.add_plant_to_week(week, plant)

      assert {:ok, _} = Log.remove_plant_from_week(week, plant)

      assert [] = Log.list_week_plants(week)
    end

    test "remove_plant_from_week/2 with invalid data returns error changeset" do
      assert {:error, _} = Log.remove_plant_from_week(nil, nil)
    end
  end
end
