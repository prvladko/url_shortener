defmodule Shorty.Repo.Migrations.CreateShortLinks do
  use Ecto.Migration

  def change do
    create table(:short_links) do
      add :" key", :string
      add :" url", :text
      add :" hit_count", :integer

      timestamps()
    end
  end
end
