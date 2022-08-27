defmodule AppWeb.Schema.Middleware.HandleError do
  @moduledoc """
  This middleware is responsible for unpacking Ecto.Changeset
  errors into the appropriate format for Absinthe to process
  and map to the GraphQL Specification
  """
  @behaviour Absinthe.Middleware

  import Enum, only: [flat_map: 2, map: 2]
  import Ecto.Changeset, only: [traverse_errors: 2]

  def call(resolution, _) do
    %{resolution | errors: flat_map(resolution.errors, &handle_error/1)}
  end

  defp handle_error(%Ecto.Changeset{} = changeset) do
    changeset
    |> traverse_errors(fn {err, _opts} -> err end)
    |> map(fn {k, v} -> "#{k}: #{v}" end)
  end

  defp handle_error(error), do: [error]
end
