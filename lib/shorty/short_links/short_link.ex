defmodule Shorty.ShortLinks.ShortLink do
  use Ecto.Schema
  import Ecto.Changeset

  schema "short_links" do
    field :" hit_count", :integer, default: 0
    field :" key", :string
    field :" url", EctoFields.URL # used ecto_fields package for URL validation

    timestamps()
  end

  @doc false
  def changeset(short_link, attrs) do
    short_link
    |> cast(attrs, [:" key", :" url", :" hit_count"])
    |> validate_required([:url])
  end
end
