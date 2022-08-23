defmodule AppWeb.Schema.TodoTypes do
  @moduledoc """
  Representation of Todo Model in the Schema.
  """
  use Absinthe.Schema.Notation
  alias AppWeb.Resolvers
  alias AppWeb.Schema.Middleware

  import_types(AppWeb.Schema.EnumTypes)

  # Types

  @desc "Todo"
  object :todo do
    @desc "Date todo was archived."
    field(:archived_at, :datetime)
    @desc "Date todo was created."
    field(:created_at, non_null(:datetime))
    @desc "Date todo was deleted."
    field(:deleted_at, :datetime)
    @desc "Description of todo."
    field(:description, :string)
    @desc "Date todo is set to end."
    field(:end_date, non_null(:datetime))
    field(:id, non_null(:id))
    @desc "Date todo was last modified."
    field(:modified_at, non_null(:datetime))
    @desc "Name of todo."
    field(:name, non_null(:string))
    @desc "Date todo is set to start."
    field(:start_date, non_null(:datetime))
    @desc "Status of todo."
    field(:status, non_null(:todo_status))
  end

  # Queries

  @desc "Todo Queries"
  object :todo_queries do
    @desc "Get all todos."
    field :todos, non_null(list_of(:todo)) do
      resolve(&Resolvers.Content.todos/3)
      middleware(Middleware.HandleError)
    end

    @desc "Get a todo."
    field :todo, :todo do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Content.todo/3)
      middleware(Middleware.HandleError)
    end
  end

  # Mutations

  @desc "Todo Mutations"
  object :todo_mutations do
    @desc "Add Todo."
    field :add_todo, non_null(:todo_payload) do
      arg(:inputs, non_null(:add_todo_inputs))
      resolve(&Resolvers.Content.add_todo/3)
      middleware(Middleware.HandleError)
    end
  end

  # Mutation Inputs

  @desc "Inputs for Adding a Todo."
  input_object :add_todo_inputs do
    field(:description, :string)
    field(:end_date, non_null(:datetime))
    field(:name, non_null(:string))
    field(:start_date, non_null(:datetime))
  end

  # Mutation Payloads
  @desc "Todo Payload."
  object :todo_payload do
    field(:data, :todo)
    field(:errors, list_of(non_null(:error_type)))
  end
end
