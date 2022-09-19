defmodule Shorty.ShortLinks.Pubsub do
  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(MyApp.PubSub, @topic)
  end

  def broadcast_record({:ok, record}, event) when is_struct(record) do
    Phoenix.PubSub.broadcast(Shorty.PubSub, @topic, {event, record})
    {:ok, record}
  end

  def broadcast_record({:error, reason}, _event), do: {:error, reason}
end
