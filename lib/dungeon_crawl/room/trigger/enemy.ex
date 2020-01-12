defmodule DungeonCrawl.Room.Triggers.Enemy do
  @behaviour DungeonCrawl.Room.Trigger

  alias Mix.Shell.IO, as: Shell
  alias DungeonCrawl.Room.Action

  def run(character, %DungeonCrawl.Room.Action{id: :forward}) do
    enemy = Enum.random(DungeonCrawl.Enemies.all)

    Shell.info(enemy.description)
    Shell.info("The enemy #{enemy.name} wants to fight.")
    Shell.info("You were prepared and attack first.")
    {updated_char, _enemy} = DungeonCrawl.Battle.fight(character, enemy)

    {updated_char, :forward}
  end

  def run(character, %Action{id: :escape}) do
    enemy = Enum.random(DungeonCrawl.Enemies.all)

    Shell.info(enemy.description)
    Shell.info("The enemy #{enemy.name} wants to fight.")
    Shell.info("You however try to escape to a different room")
    Shell.info("They have time to attack you once")
    updated_char = DungeonCrawl.Battle.attack(enemy, character)

    {updated_char, :escape}
  end
end
