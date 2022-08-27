defmodule AppWeb.Schema.Mutations.AddTodoTest do
  use AppWeb.ConnCase, async: true

  @query """
  mutation AddTodo($inputs: AddTodoInputs!) {
    result: addTodo(inputs: $inputs) {
      data {
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

  test "add_todo query returns todo" do
    inputs = %{
      endDate: to_string(~U[2022-08-26T23:59:00.000000Z]),
      name: "Test Todo",
      startDate: to_string(~U[2022-08-26T22:59:00.000000Z])
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
    assert data["name"] == inputs.name
  end

  test "add_todo query returns errors for required inputs" do
    inputs = %{
      endDate: "2022-08-23T09:00:00.000000Z",
      name: "",
      startDate: "2022-08-26T09:00:00.000000Z"
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

  test "add_todo query returns error for start_date after end_date" do
    inputs = %{
      endDate: "2022-08-23T09:00:00.000000Z",
      name: "Test Todo",
      startDate: "2022-08-26T09:00:00.000000Z"
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
