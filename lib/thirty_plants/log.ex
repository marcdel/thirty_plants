defmodule ThirtyPlants.Log do
  @moduledoc """
  The Log context.
  """

  import Ecto.Query, warn: false

  alias ThirtyPlants.Repo
  alias ThirtyPlants.Log.Plant

  @doc """
  Returns the list of plants.

  ## Examples

      iex> list_plants()
      [%Plant{}, ...]

  """
  def list_plants do
    Repo.all(Plant)
  end

  @doc """
  Gets a single plant.

  Raises `Ecto.NoResultsError` if the Plant does not exist.

  ## Examples

      iex> get_plant!(123)
      %Plant{}

      iex> get_plant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_plant!(id), do: Repo.get!(Plant, id)

  @doc """
  Creates a plant.

  ## Examples

      iex> create_plant(%{field: value})
      {:ok, %Plant{}}

      iex> create_plant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_plant(attrs \\ %{}) do
    %Plant{}
    |> Plant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a plant.

  ## Examples

      iex> update_plant(plant, %{field: new_value})
      {:ok, %Plant{}}

      iex> update_plant(plant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_plant(%Plant{} = plant, attrs) do
    plant
    |> Plant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a plant.

  ## Examples

      iex> delete_plant(plant)
      {:ok, %Plant{}}

      iex> delete_plant(plant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_plant(%Plant{} = plant) do
    Repo.delete(plant)
  end

  alias ThirtyPlants.Log.Week
  alias ThirtyPlants.Accounts.User

  @doc """
  Gets a single week.

  Raises `Ecto.NoResultsError` if the Week does not exist.

  ## Examples

      iex> get_week!(123)
      %Week{}

      iex> get_week!(456)
      ** (Ecto.NoResultsError)

  """
  def get_week!(id), do: Repo.get!(Week, id)

  @doc """
  Returns the current week for a user.

  ## Examples

      iex> current_week(user)
      %Week{}

      iex> current_week(user)
      nil
  """
  def current_week(user) do
    today = Date.utc_today()

    from(w in Week, where: w.user_id == ^user.id, order_by: [desc: :start_date], limit: 1)
    |> Repo.one()
    |> case do
      nil ->
        {:error, nil}

      week ->
        case Date.compare(week.end_date, today) do
          :lt -> {:error, week}
          :eq -> {:error, week}
          :gt -> {:ok, week}
        end
    end
  end

  @doc """
  Creates a week.

  ## Examples

      iex> create_week(%{field: value})
      {:ok, %Week{}}

      iex> create_week(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_week(%User{} = user, attrs \\ %{}) do
    attrs =
      Map.merge(
        %{
          user_id: user.id,
          start_date: Date.utc_today(),
          end_date: Date.add(Date.utc_today(), 7)
        },
        attrs
      )

    %Week{}
    |> Week.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a week.

  ## Examples

      iex> delete_week(week)
      {:ok, %Week{}}

      iex> delete_week(week)
      {:error, %Ecto.Changeset{}}

  """
  def delete_week(%Week{} = week) do
    Repo.delete(week)
  end

  alias ThirtyPlants.Log.WeekPlant

  @doc """
  Returns the list of plants for a week.

  ## Examples

      iex> list_week_plants()
      [%Plant{}, ...]

  """
  def list_week_plants(%{id: week_id}) do
    Repo.all(
      from p in Plant,
        join: wp in WeekPlant,
        on: wp.plant_id == p.id,
        where: wp.week_id == ^week_id,
        select: p
    )
  end

  @doc """
  Creates a week_plant.

  ## Examples

      iex> create_week_plant(%{field: value})
      {:ok, %WeekPlant{}}

      iex> create_week_plant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_week_plant(attrs \\ %{}) do
    %WeekPlant{}
    |> WeekPlant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Adds a plant to a week.

  ## Examples

      iex> add_plant_to_week(week, plant)
      {:ok, %WeekPlant{}}

      iex> add_plant_to_week(week, plant)
      {:error, %Ecto.Changeset{}}
  """
  def add_plant_to_week(week, plant) do
    attrs = %{week_id: week && week.id, plant_id: plant && plant.id}
    create_week_plant(attrs)
  end

  @doc """
  Removes a plant from a week.

  ## Examples

      iex> remove_plant_from_week(week, plant)
      {:ok, nil}

      iex> remove_plant_from_week(week, plant)
      {:error, nil}
  """
  def remove_plant_from_week(week, plant) when is_nil(week) or is_nil(plant) do
    {:error, nil}
  end

  def remove_plant_from_week(%{id: week_id}, %{id: plant_id})
      when is_nil(week_id) or is_nil(plant_id) do
    {:error, nil}
  end

  def remove_plant_from_week(%{id: week_id}, %{id: plant_id}) do
    Repo.delete_all(
      from wp in WeekPlant,
        where: wp.week_id == ^week_id and wp.plant_id == ^plant_id
    )
    |> case do
      # There should only ever be one match, anything else is an error
      {1, _} -> {:ok, nil}
      _ -> {:error, nil}
    end
  end
end
