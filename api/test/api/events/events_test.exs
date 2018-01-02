defmodule Api.EventsTest do
  use Api.DataCase

  alias Api.Events

  describe "events" do
    alias Api.Events.Event

    @valid_attrs %{date: ~N[2010-04-17 14:00:00.000000], description: "some description", group_name: "some group_name", link: "some link", name: "some name", rsvp: 42}
    @update_attrs %{date: ~N[2011-05-18 15:01:01.000000], description: "some updated description", group_name: "some updated group_name", link: "some updated link", name: "some updated name", rsvp: 43}
    @invalid_attrs %{date: nil, description: nil, group_name: nil, link: nil, name: nil, rsvp: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Events.create_event(@valid_attrs)
      assert event.date == ~N[2010-04-17 14:00:00.000000]
      assert event.description == "some description"
      assert event.group_name == "some group_name"
      assert event.link == "some link"
      assert event.name == "some name"
      assert event.rsvp == 42
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, event} = Events.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.date == ~N[2011-05-18 15:01:01.000000]
      assert event.description == "some updated description"
      assert event.group_name == "some updated group_name"
      assert event.link == "some updated link"
      assert event.name == "some updated name"
      assert event.rsvp == 43
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end
end
