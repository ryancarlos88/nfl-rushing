defmodule NflRushing.Integration.PlayerRushingTest do
  alias NflRushing.Integration.PlayerRushing, as: Integrator

  use NflRushing.DataCase

  describe "read_json_data/1" do
    test "should read a json file" do
      result = "priv/data/rushing_sample.json"
      |> Integrator.read_json_data()
      |> Enum.at(0)

      assert result == %{"1st" => 0, "1st%" => 0, "20+" => 0, "40+" => 0, "Att" => 2, "Att/G" => 2, "Avg" => 3.5, "FUM" => 0, "Lng" => "7", "Player" => "Joe Banyard", "Pos" => "RB", "TD" => 0, "Team" => "JAX", "Yds" => 7, "Yds/G" => 7}
    end

    test "should return error if file doesn't exist" do
      result = Integrator.read_json_data("ads")
      assert result == {:error, :enoent}
    end
  end

  describe "create_map_list_from_json/1" do
    test "should read a json file" do
      result =
        "priv/data/rushing_sample.json"
        |> Integrator.read_json_data()
        |> Integrator.create_map_list_from_json()
        |> Enum.at(0)
      assert result == %{longest_rush: 7, player_name: "Joe Banyard", player_position: "RB", player_team: "JAX", rushing_20p_yards_each: 0, rushing_40p_yards_each: 0, rushing_attemps: 2, rushing_attempts_per_game_avg: 2, rushing_avg_yards_per_attempt: 3.5, rushing_first_downs: 0, rushing_first_downs_percentage: 0, rushing_fumbles: 0, rushing_yards_per_game: 7, total_rushing_touchdowns: 0, total_rushing_yards: 7, touchdown_occurred: false}
    end
  end
end
