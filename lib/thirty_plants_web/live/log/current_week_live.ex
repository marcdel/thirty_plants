defmodule ThirtyPlantsWeb.CurrentWeekLive do
  use ThirtyPlantsWeb, :live_view
  use ThirtyPlantsWeb.AppStyles

  alias ThirtyPlants.Accounts
  alias ThirtyPlants.Log
  alias ThirtyPlantsWeb.PlantRow

  @impl true
  def mount(params, _session, socket) do
    email = Map.get(params, "email", 0)
    user = Accounts.get_user_by_email(email)
    count = ThirtyPlants.plant_count(user)

    {:ok,
     assign(socket, email: email, user: user, count: count, filter: "", plants: get_plants(user))}
  end

  @impl true
  def render(%{format: :swiftui} = assigns) do
    swiftui_sigil_block(assigns)
  end

  @impl true
  def render(%{} = assigns) do
    ~H"""
    <div class="flex w-full h-screen items-center">
      <span class="w-full text-center">
        New Week!
      </span>
    </div>
    """
  end

  @impl true
  def handle_event("filter-changed", %{"text" => filter}, socket) do
    plants =
      Enum.map(socket.assigns.plants, fn plant ->
        match? = String.contains?(plant.name, filter)
        Map.put(plant, :show, match?)
      end)

    socket =
      socket
      |> assign(filter: filter)
      |> assign(plants: plants)

    {:noreply, socket}
  end

  @impl true
  def handle_event("select-item", %{"id" => id}, socket) do
    user = socket.assigns.user
    id = String.to_integer(id)

    plants =
      Enum.map(socket.assigns.plants, fn plant ->
        if plant.id == id do
          if plant.selected do
            ThirtyPlants.remove_plant(user, plant)
          else
            ThirtyPlants.add_plant(user, plant)
          end

          Map.put(plant, :selected, !plant.selected)
        else
          plant
        end
      end)

    selection = Enum.filter(plants, & &1.selected)
    socket = assign(socket, selection: selection, count: length(selection))

    {:noreply, assign(socket, plants: plants)}
  end

  defp get_plants(user) do
    current_plants = ThirtyPlants.current_plants(user)

    Log.list_plants()
    |> Enum.map(fn plant ->
      %PlantRow{
        id: plant.id,
        name: plant.name,
        selected: Enum.member?(current_plants, plant),
        show: true
      }
    end)
  end

  # This fucks the syntax highlighting and formatting of everything after it so it can fuck off down here all by itself
  defp swiftui_sigil_block(assigns) do
    ~SWIFTUI"""
    <VStack class="px-10">
      <Text><%= @count %>/30 Plants</Text>
      <Text>Whatcha eatin'?</Text>
      <TextField class="input" text={@filter} phx-change="filter-changed" />
      <List>
        <%= for plant <- Enum.filter(@plants, & &1.show) do %>
          <HStack>
            <Text :if={plant.selected}>✅</Text>
            <Button phx-click="select-item" phx-value-id={plant.id}>
              <Text class="fg-color-primary"><%= plant.name %></Text>
            </Button>
          </HStack>
        <% end %>
      </List>
    </VStack>
    """
  end
end
