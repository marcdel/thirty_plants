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

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking plant changes.

  ## Examples

      iex> change_plant(plant)
      %Ecto.Changeset{data: %Plant{}}

  """
  def change_plant(%Plant{} = plant, attrs \\ %{}) do
    Plant.changeset(plant, attrs)
  end

  alias ThirtyPlants.Log.Week
  alias ThirtyPlants.Accounts.User

  @doc """
  Returns the list of weeks.

  ## Examples

      iex> list_weeks()
      [%Week{}, ...]

  """
  def list_weeks do
    Repo.all(Week)
  end

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
  Creates a week.

  ## Examples

      iex> create_week(%{field: value})
      {:ok, %Week{}}

      iex> create_week(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_week(%User{} = user, attrs \\ %{}) do
    attrs =
      Map.merge(attrs, %{
        user_id: user.id,
        start_date: Date.utc_today(),
        end_date: Date.add(Date.utc_today(), 7)
      })

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

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking week changes.

  ## Examples

      iex> change_week(week)
      %Ecto.Changeset{data: %Week{}}

  """
  def change_week(%Week{} = week, attrs \\ %{}) do
    Week.changeset(week, attrs)
  end

  alias ThirtyPlants.Log.WeekPlant

  @doc """
  Returns the list of week_plants.

  ## Examples

      iex> list_week_plants()
      [%WeekPlant{}, ...]

  """
  def list_week_plants do
    Repo.all(WeekPlant)
  end

  @doc """
  Gets a single week_plant.

  Raises `Ecto.NoResultsError` if the Week plant does not exist.

  ## Examples

      iex> get_week_plant!(123)
      %WeekPlant{}

      iex> get_week_plant!(456)
      ** (Ecto.NoResultsError)

  """
  def get_week_plant!(id), do: Repo.get!(WeekPlant, id)

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
  Deletes a week_plant.

  ## Examples

      iex> delete_week_plant(week_plant)
      {:ok, %WeekPlant{}}

      iex> delete_week_plant(week_plant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_week_plant(%WeekPlant{} = week_plant) do
    Repo.delete(week_plant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking week_plant changes.

  ## Examples

      iex> change_week_plant(week_plant)
      %Ecto.Changeset{data: %WeekPlant{}}

  """
  def change_week_plant(%WeekPlant{} = week_plant, attrs \\ %{}) do
    WeekPlant.changeset(week_plant, attrs)
  end
end
