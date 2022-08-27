# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     App.Repo.insert!(%App.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Faker
alias App.Repo
alias App.Content.Todo

# Seed the database with 10 todos.
for _ <- 1..10 do
  %Todo{
    description: Faker.Lorem.paragraph(1),
    end_date:
      Faker.DateTime.between(
        DateTime.to_naive(DateTime.utc_now()),
        DateTime.to_naive(Faker.DateTime.forward(30))
      ),
    name: Faker.Lorem.word(),
    start_date: DateTime.utc_now()
  }
  |> Repo.insert!()
end
