defmodule Shorty.Repo.Migrations.CreateShortLinks do
  use Ecto.Migration

  def change do
    create table(:short_links) do
      add :" key", :string, null: false # Add not-null constraint
      add :" url", :text, null: false
      add :" hit_count", :integer, default: 0 #Add default value 0

      timestamps()
    end

    create index(:short_links, [:key], unique: true)
  end
end
