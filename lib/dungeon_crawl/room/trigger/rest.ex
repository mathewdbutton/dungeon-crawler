defmodule DungeonCrawl.Room.Triggers.Rest do
  @behaviour DungeonCrawl.Room.Trigger

  alias Mix.Shell.IO, as: Shell

  def run(character, %DungeonCrawl.Room.Action{id: :rest}) do
    heal_amount = :rand.uniform(5)
    Shell.info("You've found a comfy bed")
    Shell.info("Time for a quick kip and then back to it, eh?")
    updated_char = DungeonCrawl.Character.heal(character, heal_amount)

    List.duplicate("Z", heal_amount)
    |> delayed_printing()

    Shell.info("You've been healed for #{heal_amount} HP")
    Shell.info(DungeonCrawl.Character.current_stats(character))

    {updated_char, :rest}
  end

  def run(character, %DungeonCrawl.Room.Action{id: :forward}) do
    Shell.info("Passing on a nap aye, you're brave")
    delayed_printing([".", ".", ".", "or foolish"])
    {character, :forward}
  end

  defp sleep(string, sleep) do
    Process.sleep(sleep)
    IO.write(string)
  end

  defp delayed_printing(words, sleep_time \\ 1000)

  defp delayed_printing([], sleep_time) do
    sleep("\n", sleep_time)
  end

  defp delayed_printing([first | rest], sleep_time) do
    sleep(first, sleep_time)
    delayed_printing(rest, sleep_time)
  end
end
