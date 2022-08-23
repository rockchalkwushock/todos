defmodule App.Content.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  @optional_fields ~w(archived_at deleted_at description status)a
  @required_fields ~w(end_date name start_date)a
  @timestamps_opts [inserted_at: :created_at, type: :utc_datetime_usec, updated_at: :modified_at]

  schema "todos" do
    field(:archived_at, :utc_datetime_usec)
    field(:deleted_at, :utc_datetime_usec)
    field(:description, :string)
    field(:end_date, :utc_datetime_usec)
    field(:name, :string)
    field(:start_date, :utc_datetime_usec)

    field(:status, Ecto.Enum,
      values: [:archived, :finished, :in_progress, :unstarted],
      default: :unstarted
    )

    timestamps(@timestamps_opts)
  end

  def changeset(todo, attrs) do
    todo
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_start_date_before_end_date()
  end

  defp validate_start_date_before_end_date(changeset) do
    case changeset.valid? do
      true ->
        start_date = get_field(changeset, :start_date)
        end_date = get_field(changeset, :end_date)

        case Date.compare(start_date, end_date) do
          :gt ->
            add_error(changeset, :start_date, "cannot be after :end_date")

          _ ->
            changeset
        end

      _ ->
        changeset
    end
  end
end
