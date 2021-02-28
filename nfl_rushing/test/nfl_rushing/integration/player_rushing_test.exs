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

describe "prepare_rushings_to_csv/1" do
  test "should convert list to csv string" do

  result =
    "priv/data/rushing_sample.json"
    |> Integrator.read_json_data()
    |> Integrator.create_map_list_from_json()
    |> Integrator.prepare_rushings_to_csv()

    assert result == "longest_rush,player_name,player_position,player_team,rushing_20p_yards_each,rushing_40p_yards_each,rushing_attemps,rushing_attempts_per_game_avg,rushing_avg_yards_per_attempt,rushing_first_downs,rushing_first_downs_percentage,rushing_fumbles,rushing_yards_per_game,total_rushing_touchdowns,total_rushing_yards,touchdown_occurred\r\n7,Joe Banyard,RB,JAX,0,0,2,2,3.5,0,0,0,7,0,7,false\r\n9,Shaun Hill,QB,MIN,0,0,5,1.7,1,0,0,0,1.7,0,5,false\r\n2,Breshad Perriman,WR,BAL,0,0,1,0.1,2,0,0,0,0.1,0,2,false\r\n2,Charlie Whitehurst,QB,CLE,0,0,2,2,0.5,0,0,0,1,0,1,false\r\n10,Lance Dunbar,RB,DAL,0,0,9,0.7,3.4,3,33.3,0,2.4,1,31,false\r\n75,Mark Ingram,RB,NO,4,2,205,12.8,5.1,49,23.9,2,65.2,6,1043,true\r\n5,Reggie Bush,RB,BUF,0,0,12,0.9,-0.3,2,16.7,1,-0.2,1,-3,false\r\n26,Lucky Whitehead,WR,DAL,1,0,10,0.7,8.2,4,40,1,5.5,0,82,false\r\n0,Brett Hundley,QB,GB,0,0,3,0.8,-0.7,0,0,1,-0.5,0,-2,false\r\n70,Tyreek Hill,WR,KC,4,2,24,1.5,11.1,10,41.7,0,16.7,3,267,true\r\n14,Randall Cobb,WR,GB,0,0,10,0.8,3.3,4,40,0,2.5,0,33,false\r\n15,Aaron Ripkowski,FB,GB,0,0,34,2.1,4.4,10,29.4,0,9.4,2,150,false\r\n10,Chris Moore,WR,BAL,0,0,3,0.2,6.3,1,33.3,0,1.3,0,19,false\r\n74,Jeremy Hill,RB,CIN,5,3,222,14.8,3.8,42,18.9,0,55.9,9,839,true\r\n11,Kenneth Farrow,RB,SD,0,0,60,4.6,3.2,10,16.7,1,14.8,0,192,false\r\n"
  end
end
end
