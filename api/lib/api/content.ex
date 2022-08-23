defmodule App.Content do
  @moduledoc """
  Entry point for all Content related models.
  """
  import Ecto.Query, warn: false
  alias App.Repo
  alias App.Content.Todo

  def get_todo!(id), do: Repo.get!(Todo, id)

  def list_todos, do: Repo.all(Todo)

  def create_todo(attrs) do
    %Todo{}
    |> Todo.changeset(attrs)
    |> Repo.insert()
  end
end
