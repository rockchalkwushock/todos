defmodule AppWeb.Resolvers.Content do
  @moduledoc """
  Resolvers for all Content Context Models
  """
  alias App.Content
  alias App.Content.{Todo}

  # Todo Queries

  def todo(_, %{id: id}, _) do
    case Content.get_todo(id) do
      # HACK:
      # Using get!/3 like I would prefer is not catchable since it raises
      # Ecto.NoResultsError instead of returning a changeset.errors
      # So if we encounter "nil" we didn't find anything and should let the
      # user know.
      nil ->
        {:error, message: "No todo with id: #{id} was found."}

      # FIXME: How to capture this pattern? %App.Content.Todo{...}
      _ ->
        {:ok, Content.get_todo(id)}
    end
  end

  def todos(_, _, _) do
    {:ok, Content.list_todos()}
  end

  # Todo Mutations

  def add_todo(_, %{inputs: inputs}, _) do
    case Content.create_todo(inputs) do
      {:error, changeset} ->
        {:error, changeset}

      {:ok, %Todo{} = todo} ->
        {:ok, %{data: todo}}
    end
  end

  def edit_todo(_, %{inputs: inputs}, _) do
    # FIXME: This will fail if the :id does not exist.
    todo = Content.get_todo(inputs[:id])

    case Content.update_todo(todo, inputs) do
      {:error, changeset} ->
        {:error, changeset}

      {:ok, todo} ->
        {:ok, %{data: todo}}
    end
  end

  def remove_todo(_, %{inputs: inputs}, _) do
    # FIXME: This will fail if the :id does not exist.
    todo = Content.get_todo(inputs[:id])

    case Content.delete_todo(todo) do
      {:error, changeset} ->
        {:error, changeset}

      {:ok, todo} ->
        {:ok, %{data: todo}}
    end
  end
end
