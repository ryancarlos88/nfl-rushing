defmodule NflRushing.Adapter.PlayerRushingTest do
  alias NflRushing.Adapter.PlayerRushing, as: Adapter

  use NflRushing.DataCase

  describe "create_entity_params_from_map/1" do
    test "should create an entity from map" do
      result = Adapter.create_entity_params_from_map(%{
        "1st": 0,
        "1st%": 0,
        "20+": 0,
        "40+": 0,
        "Att": 2,
        "Att/G": 2,
        "Avg": 3.5,
        "FUM": 0,
        "Lng": "7",
        "Player": "Joe Banyard",
        "Pos": "RB",
        "TD": 0,
        "Team": "JAX",
        "Yds": 7,
        "Yds/G": 7})

      assert result == %{longest_rush: 7, player_name: "Joe Banyard", player_position: "RB", player_team: "JAX", rushing_20p_yards_each: 0, rushing_40p_yards_each: 0, rushing_attemps: 2, rushing_attempts_per_game_avg: 2, rushing_avg_yards_per_attempt: 3.5, rushing_first_downs: 0, rushing_first_downs_percentage: 0, rushing_fumbles: 0, rushing_yards_per_game: 7, total_rushing_touchdowns: 0, total_rushing_yards: 7, touchdown_occurred: false}
    end
  end

end
