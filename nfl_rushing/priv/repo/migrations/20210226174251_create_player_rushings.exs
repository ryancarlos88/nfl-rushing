defmodule NflRushing.Repo.Migrations.CreatePlayerRushings do
  use Ecto.Migration

  def change do
    create table(:player_rushings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :player_name, :string
      add :player_team, :string
      add :player_position, :string
      add :rushing_attempts_per_game_avg, :decimal
      add :rushing_attemps, :integer
      add :total_rushing_yards, :integer
      add :rushing_avg_yards_per_attempt, :decimal
      add :rushing_yards_per_game, :decimal
      add :total_rushing_touchdowns, :integer
      add :longest_rush, :integer
      add :touchdown_occurred, :boolean, default: false, null: false
      add :rushing_first_downs, :integer
      add :rushing_first_downs_percentage, :decimal
      add :rushing_20p_yards_each, :integer
      add :rushing_40p_yards_each, :integer
      add :rushing_fumbles, :integer

      timestamps()
    end

  end
end
