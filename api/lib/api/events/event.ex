defmodule Api.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias Api.Events.Event

  schema "events" do
    field :date, :naive_datetime
    field :description, :string
    field :duration, :integer
    field :link, :string
    field :name, :string
    field :rsvp, :integer
    field :group_name, :string
    field :source, :string

    timestamps()
  end

  @doc false
  def changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, [:name, :duration, :date, :rsvp, :link, :description])
    |> validate_required([:name, :description])
  end
end
