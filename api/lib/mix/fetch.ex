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
      "AWS-Seattle-OfficialEvents",
      "Adas-UX-Book-Club",
      "Beer-Code-Seattle",
      "Beerly-Functional",
      "BeerswithEngineers",
      "Carbon-Five-Seattle-Hack-Nights",
      "Docker-Seattle",
      "FSharpSeattle",
      "Ladies-in-Seattle-Tech",
      "Learn-Code-Seattle"
      "Lisp-Seattle",
      "Metis-Seattle-Data-Science",
      "NET-Developers-Association-Eastside",
      "OperationCode-SeattleWA",
      "PSPPython",
      "Papers-We-Love-Seattle",
      "QASIG-Seattle-Innovations-in-Software-Testing-Meetup",
      "SEAHUG",
      "SeaLang",
      "Seajure",
      "Seattle-Apache-Kafka-Meetup",
      "Seattle-Artificial-Intelligence-Meetup",
      "Seattle-Elasticsearch-Meetup",
      "Seattle-Elixir-Programming-Meetup",
      "Seattle-Kotlin",
      "Seattle-Kubernetes-Meetup",
      "Seattle-Node-js",
      "Seattle-Rust-Meetup",
      "Seattle-Scala-User-Group",
      "Seattle-Scalability-Meetup",
      "Seattle-Software-Development-Meetup",
      "Seattle-University-Web-Developers-Meetup",
      "SeattleWordPressMeetup",
      "SwiftSeattle",
      "The-Seattle-Ruby-on-Rails-Developers-Meetup-Group",
      "WIGI-Meetups",
      "codefellows",
      "golang",
      "openseattle",
      "pydata_seattle",
      "seabtc",
      "seattle-api",
      "seattle-react-js",
      "seattle-software-craftsmanship",
      "seattlejs",
      "seattlejshackers",
      "software_developer_study_group",
      "techinterviews",
      "xcoders",
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


