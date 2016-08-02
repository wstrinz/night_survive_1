defmodule BirdsAndTrees.Repo.Migrations.CreatePlaces do
  use Ecto.Migration

  def change do
    create table(:places) do
      add :name, :string
      add :lat, :float
      add :lng, :float
      add :role, :string
    end
  end
end
