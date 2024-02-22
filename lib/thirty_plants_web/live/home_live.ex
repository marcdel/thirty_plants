defmodule ThirtyPlantsWeb.HomeLive do
  use ThirtyPlantsWeb, :live_view
  use ThirtyPlantsWeb.HomeLiveStyles

  @impl true
  def mount(params, _session, socket) do
    count = Map.get(params, "count", 0)
    {:ok, assign(socket, count: count)}
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

  # This fucks the syntax highlighting and formatting of everything after it so it can fuck off down here all by itself
  defp swiftui_sigil_block(assigns) do
    ~SWIFTUI"""
    <VStack class="px-10">
      <Text>
        <%= @count %>/30 Plants
      </Text>
      <NavigationLink destination="/add"><Text>Add</Text></NavigationLink>
    </VStack>
    """
  end
end
