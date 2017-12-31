defmodule Api.Scrapers.Meetup do
  def fetch(meetup_name) do
    host = "https://api.meetup.com"
    url = "#{host}/#{meetup_name}/events"

    {:ok, %{body: body}} = HTTPoison.get(url)

    body |> Poison.decode!
  end
end
