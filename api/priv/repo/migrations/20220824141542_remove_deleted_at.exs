defmodule App.Repo.Migrations.RemoveDeletedAt do
  use Ecto.Migration

  def up do
    alter table(:todos) do
      remove_if_exists :deleted_at, :utc_datetime_usec
    end
  end

  def down do
    alter table(:todos) do
      add_if_not_exists :deleted_at, :utc_datetime_usec
    end
  end
end
