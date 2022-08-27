defmodule App.Content do
  @moduledoc """
  Entry point for all Content related models.
  """
  import Ecto.Query, warn: false
  alias App.Repo
  alias App.Content.Todo

  ##############################################
  ###################Queries####################
  ##############################################

  def get_todo(id), do: Repo.get(Todo, id)

  def list_todos, do: Repo.all(Todo)

  ##############################################
  ####################Actions###################
  ##############################################

  def create_todo(attrs) do
    %Todo{}
    |> Todo.changeset(attrs)
    |> Repo.insert()
  end

  def delete_todo(%Todo{} = todo), do: Repo.delete(todo)

  def update_todo(%Todo{} = todo, %{ status: :archived } = _attrs) do
    todo
      |> Todo.changeset(%{archived_at: DateTime.now!("Etc/UTC"), status: :archived })
      |> Repo.update()
  end

  def update_todo(%Todo{} = todo, attrs) do
    todo
      |> Todo.changeset(attrs)
      |> Repo.update()
  end
end
