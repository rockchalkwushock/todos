defmodule AppWeb.Resolvers.Content do
  @moduledoc """
  Resolvers for all Content Context Models
  """
  alias App.Content

  # Todo Queries

  def todo(_, %{id: id}, _) do
    {:ok, Content.get_todo!(id)}
  end

  def todos(_, _, _) do
    {:ok, Content.list_todos()}
  end

  # Todo Mutations

  def add_todo(_, %{inputs: inputs}, _) do
    case Content.create_todo(inputs) do
      {:error, changeset} ->
        {:error, changeset}

      {:ok, todo} ->
        {:ok, %{data: todo}}
    end
  end
end
