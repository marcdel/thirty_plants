defmodule ThirtyPlantsWeb.FakeLoginLive do
  use ThirtyPlantsWeb, :live_view
  use ThirtyPlantsWeb.AppStyles

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, email: "user@email.com")}
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
  def handle_event("email-changed", %{"email" => email}, socket) do
    {:noreply, assign(socket, email: email)}
  end

  @impl true
  def handle_event("sign-in", _params, socket) do
    email = socket.assigns.email
    {:noreply, push_navigate(socket, to: "/home?email=#{email}")}
  end

  # This fucks the syntax highlighting and formatting of everything after it so it can fuck off down here all by itself
  defp swiftui_sigil_block(assigns) do
    ~SWIFTUI"""
    <VStack class="px-10">
      <HStack>
        <Text>Sign in to account</Text>
      </HStack>
      <TextField class="input" text={@email} phx-change="email-changed" />
      <Button phx-click="sign-in">
        <Text class="fg-color-primary">Sign in</Text>
      </Button>
    </VStack>
    """
  end
end
