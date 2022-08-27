defmodule AppWeb.Schema.Mutations.EditTodoTest do
  use AppWeb.ConnCase, async: true

  import App.ContentFixtures

  @query """
  mutation EditTodo($inputs: EditTodoInputs!) {
    result: editTodo(inputs: $inputs) {
      data {
        archivedAt
        createdAt
        description
        endDate
        id
        modifiedAt
        name
        startDate
        status
      }
      errors {
        field
        message
      }
    }
  }
  """

  test "edit_todo query returns updated todo" do
    todo = todo_fixture()

    inputs = %{
      description: "updated todo",
      endDate: to_string(~U[2022-08-26T23:59:00.000000Z]),
      id: todo.id,
      name: "Updated Todo",
      startDate: to_string(~U[2022-08-26T22:59:00.000000Z]),
      status: "IN_PROGRESS"
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
    assert data["description"] == inputs.description
    assert data["id"] == inputs.id
    assert data["name"] == inputs.name
    assert data["status"] == "IN_PROGRESS"
  end

  test "edit_todo query returns archived todo" do
    todo = todo_fixture()

    inputs = %{
      endDate: to_string(~U[2022-08-26T23:59:00.000000Z]),
      id: todo.id,
      name: "Updated Todo",
      startDate: to_string(~U[2022-08-26T22:59:00.000000Z]),
      status: "ARCHIVED"
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
    assert data["archivedAt"]
    assert data["id"] == inputs.id
    assert data["status"] == "ARCHIVED"
  end

  test "edit_todo query returns errors for required inputs" do
    todo = todo_fixture()

    inputs = %{
      description: nil,
      endDate: to_string(~U[2022-08-26T23:59:00.000000Z]),
      id: todo.id,
      name: "",
      startDate: to_string(~U[2022-08-26T22:59:00.000000Z]),
      status: "IN_PROGRESS"
    }

    conn = build_conn()

    conn = post conn, "/api", query: @query, variables: %{inputs: inputs}

    assert %{
             "data" => data,
             "errors" => errors
           } = json_response(conn, 200)

    assert data == nil
    assert length(errors) == 1
    e = List.first(errors)
    assert e["message"] == "name: can't be blank"
  end

  test "edit_todo query returns error for start_date after end_date" do
    todo = todo_fixture()

    inputs = %{
      description: nil,
      endDate: "2022-08-23T09:00:00.000000Z",
      id: todo.id,
      name: "Test Todo",
      startDate: "2022-08-26T09:00:00.000000Z",
      status: "IN_PROGRESS"
    }

    conn = build_conn()

    conn = post conn, "/api", query: @query, variables: %{inputs: inputs}

    assert %{
             "data" => data,
             "errors" => errors
           } = json_response(conn, 200)

    assert data == nil
    assert length(errors) == 1
    e = List.first(errors)
    assert e["message"] == "start_date: cannot be after :end_date"
  end
end
