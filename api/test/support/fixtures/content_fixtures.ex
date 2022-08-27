defmodule App.ContentFixtures do
  @moduledoc """
  Test helpers for Content Context.
  """
  alias Faker
  alias App.Content

  @doc """
  Generate a todo.
  """
  alias App.Content.{Todo}

  def todo_fixture(attrs \\ %{}) do
    t =
      attrs
      |> Enum.into(%{
        end_date:
          Faker.DateTime.between(
            DateTime.to_naive(DateTime.utc_now()),
            DateTime.to_naive(Faker.DateTime.forward(30))
          ),
        name: Faker.Lorem.word(),
        start_date: DateTime.utc_now()
      })

    {:ok, %Todo{} = todo} = Content.create_todo(t)
    todo
  end
end
