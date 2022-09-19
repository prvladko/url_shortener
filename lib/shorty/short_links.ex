defmodule Shorty.ShortLinks do
  @moduledoc """
  The ShortLinks context.
  """

  import Ecto.Query, warn: false
  alias Shorty.Repo

  alias Shorty.ShortLinks.ShortLink
  # alias Shorty.ShortLinks.PubSub # TODO: uncomment later

  @doc """
  Returns the list of short_links.

  ## Examples

      iex> list_short_links()
      [%ShortLink{}, ...]

  """
  # def list_short_links do
    # Repo.all(ShortLink)
  # end

  @doc """
  Gets a single short_link.

  Raises `Ecto.NoResultsError` if the Short link does not exist.

  ## Examples

      iex> get_short_link!(123)
      %ShortLink{}

      iex> get_short_link!(456)
      ** (Ecto.NoResultsError)

  """
  # def get_short_link!(id), do: Repo.get!(ShortLink, id)
  def get_short_link_by_key(key), do: Repo.get_by(ShortLink, key: key) # Find a short link record by key

  @doc """
  Creates a short_link.

  ## Examples

      iex> create_short_link(%{field: value})
      {:ok, %ShortLink{}}

      iex> create_short_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_short_link(attrs \\ %{}) do
    attrs = maybe_assign_random_key(attrs)

    %ShortLink{}
    |> ShortLink.changeset(attrs)
    |> Repo.insert()
    # |> PubSub.broadcast_record(:short_link_inserted) # TODO: uncomment later
  rescue
    # Retry in case the same key already exists in database
    Ecto.ConstraintError ->
      create_short_link(attrs)
  end


  # Generates and assigns a random key when key is blank.
  defp maybe_assign_random_key(attrs) do
    if attrs["key"] in [nil, ""] do
      Map.put(attrs, "key", random_string(4))
    else
      attrs
    end
  end

  defp random_string(length) when is_integer(length) do
    :crypto.strong_rand_bytes(length)
    |> Base.url_encode64()
    |> String.replace(~r/[-_\=]/, "")
    |> binary_part(0, length)
  end

  @doc """
  Updates a short_link.

  ## Examples

      iex> update_short_link(short_link, %{field: new_value})
      {:ok, %ShortLink{}}

      iex> update_short_link(short_link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_short_link(%ShortLink{} = short_link, attrs) do
    short_link
    |> ShortLink.changeset(attrs)
    |> Repo.update()
    # |> PubSub.broadcast_record(:short_link_updated) # TODO: uncomment later
  end


  def increment_hit_count(short_link) do
    update_short_link(short_link, %{hit_count: short_link.hit_count + 1})
  end

  @doc """
  Deletes a short_link.

  ## Examples

      iex> delete_short_link(short_link)
      {:ok, %ShortLink{}}

      iex> delete_short_link(short_link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_short_link(%ShortLink{} = short_link) do
    Repo.delete(short_link)
    # |> PubSub.broadcast_record(:short_link_deleted) # TODO: uncomment later
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking short_link changes.

  ## Examples

      iex> change_short_link(short_link)
      %Ecto.Changeset{data: %ShortLink{}}

  """
  def change_short_link(%ShortLink{} = short_link, attrs \\ %{}) do
    ShortLink.changeset(short_link, attrs)
  end
end
