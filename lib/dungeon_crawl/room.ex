defmodule DungeonCrawl.Room do
  alias DungeonCrawl.Room
  import DungeonCrawl.Room.Action

  alias DungeonCrawl.Room.Triggers

  defstruct description: nil, actions: [], trigger: nil, weight: 0

  def all,
    do: [
      %Room{
        description: "You can see the light of day. You found the exit!",
        actions: [forward()],
        trigger: Triggers.Exit,
        weight: 10
      },
      %Room{
        description: "You can see an enemy blocking your path",
        actions: [forward()],
        trigger: Triggers.Enemy,
        weight: 100
      },
      %Room{
        description: "The room is virtually empty",
        actions: [forward(), rest()],
        trigger: Triggers.Rest,
        weight: 30
      }
    ]

  def random_room(thing) do
    Enum.map(thing, &(&1.weight))
    |> Enum.sum
    |> :rand.uniform()
    |> select_weighted_room(thing)
  end

  defp select_weighted_room(total, [room | remaining_rooms]) do
    new_total = total - room.weight

    if new_total <= 0 do
      room
    else
      select_weighted_room(new_total, remaining_rooms)
    end
  end
end
