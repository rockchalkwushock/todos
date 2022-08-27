defmodule App.ContentTest do
  use App.DataCase

  alias App.Content
  alias App.Content.{Todo}

  @invalid_attrs %{
    end_date: nil,
    name: nil,
    start_date: nil
  }
  @valid_attrs %{
    end_date: ~U[2022-08-26T20:00:00.000000Z],
    name: "Test Todo",
    start_date: ~U[2022-08-26T22:00:00.000000Z]
  }

  describe "todos" do
    import App.ContentFixtures

    test "get_todo/1 returns todo" do
      todo = todo_fixture()
      assert Content.get_todo(todo.id) == todo
    end

    test "get_todo/1 returns nil" do
      assert Content.get_todo("78d452cf-ee38-4375-877e-154c60c4c9b2") == nil
    end

    test "list_todos/0 returns list of todos" do
      todo = todo_fixture()
      assert Content.list_todos() == [todo]
    end

    test "create_todo/1 returns todo" do
      assert {:ok, %Todo{} = todo} = Content.create_todo(@valid_attrs)
      assert todo.end_date == @valid_attrs.end_date
      assert todo.name == @valid_attrs.name
      assert todo.start_date == @valid_attrs.start_date
      assert todo.status == :unstarted
    end

    test "create_todo/1 returns errors for required arguments" do
      assert {:error, %Ecto.Changeset{} = changeset} = Content.create_todo(@invalid_attrs)
      assert length(changeset.errors) == 3
    end

    test "create_todo/1 returns error for start_date after end_date" do
      attrs = Map.merge(@valid_attrs, %{start_date: ~U[2022-12-31T22:00:00.000000Z]})
      assert {:error, %Ecto.Changeset{} = changeset} = Content.create_todo(attrs)
      assert length(changeset.errors) == 1
    end

    test "update_todo/2 archives a todo" do
      todo = todo_fixture()
      attrs = %{status: :archived}

      assert todo.status == :unstarted

      assert {:ok, %Todo{} = todo} = Content.update_todo(todo, attrs)
      assert todo.archived_at
      assert todo.status == :archived
    end

    test "update_todo/2 updates a todo" do
      todo = todo_fixture()
      attrs = %{description: "short description of a todo", status: :finished}

      assert todo.status == :unstarted

      assert {:ok, %Todo{} = todo} = Content.update_todo(todo, attrs)
      assert todo.description == attrs.description
      assert todo.status == :finished
    end

    test "update_todo/2 returns errors for required fields" do
      todo = todo_fixture()

      assert todo.status == :unstarted

      assert {:error, %Ecto.Changeset{} = changeset} = Content.update_todo(todo, @invalid_attrs)
      assert length(changeset.errors) == 3
    end

    test "update_todo/2 returns errors for start_date after end_date" do
      todo = todo_fixture()
      attrs = Map.merge(@valid_attrs, %{start_date: ~U[2022-12-31T22:00:00.000000Z]})

      assert todo.status == :unstarted

      assert {:error, %Ecto.Changeset{} = changeset} = Content.update_todo(todo, attrs)
      assert length(changeset.errors) == 1
    end

    test "delete_todo/1 deletes todo" do
      todo = todo_fixture()

      assert {:ok, %Todo{}} = Content.delete_todo(todo)
      assert nil == Content.get_todo(todo.id)
    end
  end
end
