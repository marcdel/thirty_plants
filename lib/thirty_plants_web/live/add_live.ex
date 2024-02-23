defmodule ThirtyPlantsWeb.AddLive do
  use ThirtyPlantsWeb, :live_view
  use ThirtyPlantsWeb.AddLiveStyles

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(name: "")
      |> assign(plants: get_items())

    {:ok, socket}
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
        Hello web!
      </span>
    </div>
    """
  end

  @impl true
  def handle_event("name-changed", %{"text" => query}, socket) do
    plants =
      Enum.map(socket.assigns.plants, fn plant ->
        match? = String.contains?(plant.name, query)
        Map.put(plant, :show, match?)
      end)

    socket =
      socket
      |> assign(name: query)
      |> assign(plants: plants)

    {:noreply, socket}
  end

  @impl true
  def handle_event("select-item", %{"name" => name}, socket) do
    plants =
      Enum.map(socket.assigns.plants, fn plant ->
        if plant.name == name do
          Map.put(plant, :selected, !plant.selected)
        else
          plant
        end
      end)

    socket = assign(socket, selection: Enum.filter(plants, & &1.selected))

    {:noreply, assign(socket, plants: plants)}
  end

  @impl true
  def handle_event("save", _params, socket) do
    count = Enum.filter(socket.assigns.plants, & &1.selected) |> length()
    {:noreply, push_navigate(socket, to: "/home?count=#{count}")}
  end

  defp get_items do
    [
      %{
        id: 1,
        name: "Potatoes",
        description:
          "A staple in many diets, used in a variety of dishes from baked potatoes to fries.",
        position: 1,
        selected: false,
        show: true
      },
      %{
        id: 2,
        name: "Tomatoes",
        description:
          "Consumed in various forms, including fresh, as tomato sauce, and in salads.",
        position: 2,
        selected: false,
        show: true
      },
      %{
        id: 3,
        name: "Onions",
        description:
          "A base ingredient for many recipes, offering flavor to a multitude of dishes.",
        position: 3,
        selected: false,
        show: true
      },
      %{
        id: 4,
        name: "Lettuce",
        description: "A common leafy green in salads.",
        position: 4,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Corn",
        description: "Eaten on the cob, popped, or as an ingredient in many processed foods.",
        position: 5,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Apples",
        description: "A popular fruit for snacking, desserts, and juices.",
        position: 6,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Bananas",
        description: "Widely consumed for breakfast or as a snack.",
        position: 7,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Grapes",
        description: "Eaten fresh, as raisins, or used to make wine.",
        position: 8,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Carrots",
        description: "Consumed raw, cooked, or juiced.",
        position: 9,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Broccoli",
        description: "Often steamed, roasted, or added to salads and soups.",
        position: 10,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Oranges",
        description: "Eaten fresh or juiced.",
        position: 11,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Strawberries",
        description: "Popular in desserts, smoothies, or eaten fresh.",
        position: 12,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Almonds",
        description: "Eaten as snacks or used in almond milk.",
        position: 13,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Spinach",
        description: "Used in salads, smoothies, and dishes for its nutritional value.",
        position: 14,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Peppers",
        description:
          "Includes bell peppers and chili peppers, used in a variety of dishes for flavor.",
        position: 15,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Blueberries",
        description: "Consumed fresh, in smoothies, or in baked goods.",
        position: 16,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Avocados",
        description:
          "Especially popular on the West Coast, used in salads, sandwiches, and guacamole.",
        position: 17,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Garlic",
        description: "Used as a flavoring ingredient in a wide range of dishes.",
        position: 18,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Peaches",
        description: "Eaten fresh or used in desserts.",
        position: 19,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Kale",
        description: "Popular in salads, chips, and smoothies for its health benefits.",
        position: 20,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Walnuts",
        description: "Eaten as snacks or used in baking.",
        position: 21,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Lemons",
        description: "Used for their juice in cooking and beverages.",
        position: 22,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Cucumbers",
        description: "Common in salads and as pickles.",
        position: 23,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Raspberries",
        description: "Eaten fresh or used in desserts and jams.",
        position: 24,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Pears",
        description: "Consumed fresh or used in cooking and baking.",
        position: 25,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Squash",
        description: "Includes varieties like zucchini and butternut squash, used in cooking.",
        position: 26,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Cherries",
        description: "Eaten fresh, in desserts, or as juice.",
        position: 27,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Beans",
        description:
          "Including black beans, pinto beans, and kidney beans, used in a variety of dishes.",
        position: 28,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Peas",
        description: "Eaten fresh, frozen, or canned.",
        position: 29,
        selected: false,
        show: true
      },
      %{
        id: 1,
        name: "Sweet Potatoes",
        description: "Consumed baked, roasted, or in casseroles.",
        position: 30,
        selected: false,
        show: true
      }
    ]
  end

  # This fucks the syntax highlighting and formatting of everything after it so it can fuck off down here all by itself
  defp swiftui_sigil_block(assigns) do
    ~SWIFTUI"""
    <VStack class="px-10">
      <HStack>
        <Text>Whatcha eatin'?</Text>
        <Spacer />
        <Button phx-click="save">
          <Text>Save</Text>
        </Button>
      </HStack>
      <TextField class="search-box" text={@name} phx-change="name-changed" />
      <List>
        <%= for plant <- Enum.filter(@plants, & &1.show) do %>
          <HStack>
            <Text :if={plant.selected}>✅</Text>
            <Button phx-click="select-item" phx-value-name={plant.name}>
              <Text class="fg-color-primary"><%= plant.name %></Text>
            </Button>
          </HStack>
        <% end %>
      </List>
    </VStack>
    """
  end
end
