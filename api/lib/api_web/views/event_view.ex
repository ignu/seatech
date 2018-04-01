defmodule ApiWeb.EventView do
  use ApiWeb, :view
  @fields ~w(description, name, link, source, rsvp)a

  def render("index.json", %{events: events}) do
    render_many(events, ApiWeb.EventView, "show.json")
  end

  def render("show.json", %{ event: event}) do
    %{
      description: event.description,
      rsvp: event.rsvp,
      source: event.source,
      link: event.link,
      duration: event.duration,
      group_name: event.group_name,
      date: NaiveDateTime.to_iso8601(event.date)
    }
  end
end
