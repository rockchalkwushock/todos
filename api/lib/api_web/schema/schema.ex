defmodule AppWeb.Schema.Schema do
  @moduledoc """
  GraphQL Schema
  """
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(AppWeb.Schema.InternalTypes)
  import_types(AppWeb.Schema.TodoTypes)

  mutation do
    import_fields(:todo_mutations)
  end

  query do
    import_fields(:todo_queries)
  end
end
