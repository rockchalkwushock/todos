defmodule App.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  @timestamps_opts [inserted_at: :created_at, type: :utc_datetime_usec, updated_at: :modified_at]

  def change do
    create table(:todos) do
      add :archived_at, :utc_datetime_usec
      add :deleted_at, :utc_datetime_usec
      add :description, :string
      add :end_date, :utc_datetime_usec, null: false
      add :name, :string, null: false
      add :start_date, :utc_datetime_usec, null: false
      add :status, :string, default: "unstarted", null: false

      timestamps(@timestamps_opts)
    end
  end
end
