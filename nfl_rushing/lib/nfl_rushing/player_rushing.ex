defmodule NflRushing.PlayerRushing do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "player_rushings" do
    field :longest_rush, :integer
    field :player_name, :string
    field :player_position, :string
    field :player_team, :string
    field :rushing_20p_yards_each, :integer
    field :rushing_40p_yards_each, :integer
    field :rushing_attemps, :integer
    field :rushing_attempts_per_game_avg, :decimal
    field :rushing_avg_yards_per_attempt, :decimal
    field :rushing_first_downs, :integer
    field :rushing_first_downs_percentage, :decimal
    field :rushing_fumbles, :integer
    field :rushing_yards_per_game, :decimal
    field :total_rushing_touchdowns, :integer
    field :total_rushing_yards, :integer
    field :touchdown_occurred, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(player_rushing, attrs) do
    player_rushing
    |> cast(attrs, [:player_name, :player_team, :player_position, :rushing_attempts_per_game_avg, :rushing_attemps, :total_rushing_yards, :rushing_avg_yards_per_attempt, :rushing_yards_per_game, :total_rushing_touchdowns, :longest_rush, :touchdown_occurred, :rushing_first_downs, :rushing_first_downs_percentage, :rushing_20p_yards_each, :rushing_40p_yards_each, :rushing_fumbles])
    |> validate_required([:player_name, :player_team, :player_position, :rushing_attempts_per_game_avg, :rushing_attemps, :total_rushing_yards, :rushing_avg_yards_per_attempt, :rushing_yards_per_game, :total_rushing_touchdowns, :longest_rush, :touchdown_occurred, :rushing_first_downs, :rushing_first_downs_percentage, :rushing_20p_yards_each, :rushing_40p_yards_each, :rushing_fumbles])
  end
end
