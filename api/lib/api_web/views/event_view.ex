defmodule ApiWeb.EventView do
  use ApiWeb, :view

  def render("index.json", %{events: events}) do
    render_many(events, ApiWeb.EventView, "show.json")
  end

  def render("show.json", %{ event: event}) do
    IO.puts "🦄 🦄 🦄 🦄 🦄 ✨   event ✨ 🦄 🦄 🦄 🦄 🦄 🦄 "
    IO.inspect event

    %{ id: 1 }
  end
end
