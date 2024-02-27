defmodule ThirtyPlants do
  @moduledoc """
  ThirtyPlants keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias ThirtyPlants.Log

  @doc """
  Starts a new week for the given user.

  ## Examples

      iex> start_week(user)
      {:ok, %Week{}}
  """
  def start_week(user), do: Log.create_week(user)

  @doc """
  Adds a plant to the current week for the given user.

  ## Examples

      iex> add_plant(user, plant)
      {:ok, %WeekPlant{}}
  """
  def add_plant(user, plant) do
    {_, week} = Log.current_week(user)
    Log.add_plant_to_week(week, plant)
  end

  @doc """
  List all plants for the current week for the given user.

  ## Examples

      iex> current_plants(user)
      [%Plant{}, ...]
  """
  def current_plants(user) do
    {_, week} = Log.current_week(user)
    Log.list_week_plants(week)
  end

  @doc """
  Returns the number of plants for the current week for the given user.

  ## Examples

      iex> plant_count(user)
      3
  """
  def plant_count(user) do
    current_plants(user) |> length()
  end

  @doc """
  Removes a plant from the current week for the given user.

  ## Examples

      iex> remove_plant(user, plant)
      {:ok, nil}

      iex> remove_plant(user, plant)
      {:error, nil}
  """
  def remove_plant(user, plant) do
    {_, week} = Log.current_week(user)
    Log.remove_plant_from_week(week, plant)
  end
end
