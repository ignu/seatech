defmodule Api.Scrapers.MeetupTest do
  use ExUnit.Case
  alias Api.Scrapers.Meetup

  test "it can get a list of meetups " do
    events = Meetup.fetch("The-Seattle-Alternative-Boardgamers-Meetup-Group")
    assert events |> Enum.any?
  end
end
