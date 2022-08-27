defmodule AppWeb.Schema.Queries.ListTodosTest do
  use AppWeb.ConnCase, async: true

  import App.ContentFixtures

  @query """
  query ListTodos {
    todos {
      createdAt
      description
      endDate
      id
      modifiedAt
      name
      startDate
      status
    }
  }
  """

  test "list_todos/0 query returns list of todos" do
    todo = todo_fixture()

    conn = build_conn()

    conn = get conn, "/api", query: @query

    assert %{
             "data" => %{
               "todos" => todos
             }
           } = json_response(conn, 200)

    assert length(todos) == 1

    t = List.first(todos)

    assert t["id"] == todo.id
    assert t["name"] == todo.name
    assert t["status"] == "UNSTARTED"
  end

  test "list_todos query returns empty list" do
    conn = build_conn()

    conn = get conn, "/api", query: @query

    assert %{
             "data" => %{
               "todos" => todos
             }
           } = json_response(conn, 200)

    assert length(todos) == 0
  end
end
