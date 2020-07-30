defmodule PhxHelloWeb.LiveDemo do
  use Phoenix.LiveView
  import Calendar.Strftime

  def render(assigns) do
    ~L"""
    <div>
      <h1>Live View</h1>
      <p>
        Welcome <%= @name %>!
        <br/>
        It's <%= strftime!(@date, "%r") %>
        <br/>
        <h1>The count is: <%= @val %></h1>
        <button phx-click="dec">-</button>
        <button phx-click="inc">+</button>
      </p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    name = "Adi"
    if connected?(socket) do
      Process.send_after(self(), :tick, 10000)
    end
    {:ok, assign(socket, name: name, date: :calendar.local_time(), val: 0)}
  end

  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 10000)
    {:noreply, assign(socket, date: :calendar.local_time())}
  end

  def handle_event("inc", _params, socket) do
    {:noreply, assign(socket, val: (socket.assigns.val+1))}
  end

  def handle_event("dec", _params, socket) do
    {:noreply, assign(socket, val: (socket.assigns.val-1))}
  end
end
