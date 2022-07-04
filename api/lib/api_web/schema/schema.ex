defmodule AppWeb.Schema.Schema do
  use Absinthe.Schema

  @items %{
    "foo" => %{id: "foo", name: "Foo"},
    "bar" => %{id: "bar", name: "Bar"}
  }

  query do
    @desc "Test Query"
    field :item, :item do
      arg(:id, non_null(:id))

      resolve(fn %{id: item_id}, _ ->
        {:ok, @items[item_id]}
      end)
    end
  end

  @desc "An item"
  object :item do
    field(:id, :id)
    field(:name, :string)
  end
end
