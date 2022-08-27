defmodule AppWeb.Schema.Queries.GetTodoTest do
  use AppWeb.ConnCase, async: true

  import App.ContentFixtures

  @invalid_todo_id "0e31998f-503f-4218-a801-c8bb7ff9498b"
  @query """
  query GetTodo($id: ID!) {
    todo(id: $id) {
      endDate
      id
      name
      startDate
      status
    }
  }
  """

  test "get_todo/1 query returns todo" do
    todo = todo_fixture()

    assert todo.status == :unstarted

    conn = build_conn()

    conn = get conn, "/api", query: @query, variables: %{id: todo.id}

    assert %{
             "data" => %{
               "todo" => %{
                 "id" => id,
                 "name" => name,
                 "status" => status
               }
             }
           } = json_response(conn, 200)

    assert id == todo.id
    assert name == todo.name
    assert status == "UNSTARTED"
  end

  test "get_todo/1 query returns nil and error struct" do
    todo = todo_fixture()

    assert todo.status == :unstarted

    conn = build_conn()

    conn = get conn, "/api", query: @query, variables: %{id: @invalid_todo_id}

    assert %{"data" => %{"todo" => todo}, "errors" => [%{"message" => message}]} =
             json_response(conn, 200)

    assert todo == nil
    assert message == "No todo with id: #{@invalid_todo_id} was found."
  end
end
