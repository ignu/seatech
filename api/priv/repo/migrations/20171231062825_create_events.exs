defmodule Api.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :duration, :integer
      add :date, :naive_datetime
      add :rsvp, :integer
      add :link, :string
      add :description, :text
      add :group_name, :string
      add :source, :string

      timestamps()
    end
  end
end
