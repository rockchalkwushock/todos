defmodule AppWeb.Schema.Mutations.RemoveTodoTest do
  use AppWeb.ConnCase, async: true

  import App.ContentFixtures

  @query """
  mutation RemoveTodo($inputs: RemoveTodoInputs!) {
    result: removeTodo(inputs: $inputs) {
      data {
        id
      }
      errors {
        field
        message
      }
    }
  }
  """

  test "remove_todo query returns updated todo" do
    todo = todo_fixture()

    inputs = %{
      id: todo.id
    }

    conn = build_conn()

    conn = post conn, "/api", query: @query, variables: %{inputs: inputs}

    assert %{
             "data" => %{
               "result" => %{
                 "data" => data,
                 "errors" => errors
               }
             }
           } = json_response(conn, 200)

    assert errors == nil
    assert data["id"] == inputs.id
  end
end
