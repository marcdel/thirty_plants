# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ThirtyPlants.Repo.insert!(%ThirtyPlants.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ThirtyPlants.Log

plants = [
  %{name: "Potatoes"},
  %{name: "Tomatoes"},
  %{name: "Onions"},
  %{name: "Lettuce"},
  %{name: "Corn"},
  %{name: "Apples"},
  %{name: "Bananas"},
  %{name: "Grapes"},
  %{name: "Carrots"},
  %{name: "Broccoli"},
  %{name: "Oranges"},
  %{name: "Strawberries"},
  %{name: "Almonds"},
  %{name: "Spinach"},
  %{name: "Peppers"},
  %{name: "Blueberries"},
  %{name: "Avocados"},
  %{name: "Garlic"},
  %{name: "Peaches"},
  %{name: "Kale"},
  %{name: "Walnuts"},
  %{name: "Lemons"},
  %{name: "Cucumbers"},
  %{name: "Raspberries"},
  %{name: "Pears"},
  %{name: "Squash"},
  %{name: "Cherries"},
  %{name: "Beans"},
  %{name: "Peas"},
  %{name: "Sweet Potatoes"}
]

Enum.each(plants, &Log.create_plant/1)
