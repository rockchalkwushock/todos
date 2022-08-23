defmodule AppWeb.Schema.EnumTypes do
  @moduledoc """
  Enum Types in the Schema
  """
  use Absinthe.Schema.Notation

  @desc "Status of a Todo"
  enum :todo_status do
    value(:archived, description: "Archived State")
    value(:finished, description: "Finished State")
    value(:in_progress, description: "In-Progress State")
    value(:unstarted, description: "Unstarted State")
  end
end
