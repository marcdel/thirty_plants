defmodule ThirtyPlantsWeb.WeekSummaryLive do
  use ThirtyPlantsWeb, :live_view
  use ThirtyPlantsWeb.AppStyles

  alias ThirtyPlants.Accounts

  @impl true
  def mount(params, _session, socket) do
    email = Map.get(params, "email", 0)
    user = Accounts.get_user_by_email(email)
    {:ok, assign(socket, email: email, user: user)}
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
  def handle_event("start-week", _params, socket) do
    email = socket.assigns.email
    user = socket.assigns.user
    {:ok, _} = ThirtyPlants.start_week(user)

    {:noreply, push_navigate(socket, to: "/weeks/current?email=#{email}")}
  end

  # This fucks the syntax highlighting and formatting of everything after it so it can fuck off down here all by itself
  defp swiftui_sigil_block(assigns) do
    ~SWIFTUI"""
    <VStack class="px-10">
      <Text>Success! 🥳</Text>
      <Button class="button-primary" phx-click="start-week"><Text>Start Week</Text></Button>
    </VStack>
    """
  end
end
