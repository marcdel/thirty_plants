defmodule ThirtyPlants.Repo do
  use Ecto.Repo,
    otp_app: :thirty_plants,
    adapter: Ecto.Adapters.Postgres
end
