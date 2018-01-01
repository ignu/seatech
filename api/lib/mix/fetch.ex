defmodule Mix.Tasks.Fetch do
  alias __MODULE__
  use Mix.Task
  alias Api.Scrapers.Meetup
  alias Api.Event
  import Mix.Ecto

  def run(_args) do
    HTTPoison.start
    ensure_started(Api.Repo, [])
    [
      "Seattle-Elixir-Programming-Meetup",
      "OperationCode-SeattleWA",
      "seattle-software-craftsmanship",
      "QASIG-Seattle-Innovations-in-Software-Testing-Meetup",
      "software_developer_study_group",
      "seattle-api",
      "Seattle-Software-Development-Meetup",
      "SeaLang",
      "Papers-We-Love-Seattle",
      "Beer-Code-Seattle",
      "seattlejshackers",
      "seattlejs",
      "The-Seattle-Ruby-on-Rails-Developers-Meetup-Group",
      "Beerly-Functional",
      "Seattle-Scalability-Meetup",
      "openseattle",
      "seattle-react-js",
      "Seattle-Node-js",
      "Docker-Seattle",
      "xcoders",
      "Seattle-University-Web-Developers-Meetup",
      "Seattle-Rust-Meetup",
      "FSharpSeattle",
      "SEAHUG",
      "Carbon-Five-Seattle-Hack-Nights",
      "golang",
      "Seattle-Kotlin",
      "WIGI-Meetups",
      "SwiftSeattle",
      "Learn-Code-Seattle"
    ] |> Enum.each(&load_group/1)
  end

  def load_group(group) do
    Meetup.fetch(group)
    |> Enum.each(&parse_event/1)
  end

  def parse_event(event) do
    date = Mix.Tasks.Fetch.parse_date(event["local_date"], event["local_time"])

    event = %Event{
      name: event["name"],
      duration: event["duration"],
      date: date,
      link: event["link"],
      rsvp: event["yes_rsvp_count"],
      description: event["description"],
      group_name: event["group"]["name"],
      source: "meetup"
    }

    Api.Repo.insert! event
  end

  def parse_date(date, time) do
    [year, month, day] =
      date
      |> String.split("-")
      |> Enum.map(&parse_num_string/1)

    [hour, minute] =
      time
      |> String.split(":")
      |> Enum.map(&parse_num_string/1)

    {:ok, date} = NaiveDateTime.new(year, month, day, hour, minute, 0)

    date
  end

  def parse_num_string(str) do
    {number, _} = Integer.parse(str)

    number
  end
end


