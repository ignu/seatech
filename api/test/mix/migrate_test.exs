defmodule Api.Scrapers.MigrateTest do
  use ExUnit.Case

  test "can parse dates" do
    date = Mix.Tasks.Migrate.parse_date("2017-12-31", "14:00")
    assert date.year == 2017
    assert date.hour == 14
  end
end
