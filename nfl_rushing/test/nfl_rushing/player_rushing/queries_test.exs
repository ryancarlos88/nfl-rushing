defmodule NflRushing.PlayerRushing.QueriesTest do
  alias NflRushing.Integration.PlayerRushing, as: Integrator
  alias NflRushing.PlayerRushing.Queries
  alias NflRushing.PlayerRushing.Service
  alias NflRushing.Repo

  use NflRushing.DataCase

  setup do
    "priv/data/rushing_sample.json"
    |> Integrator.read_json_data()
    |> Integrator.create_map_list_from_json()
    |> Service.create_player_rushings_from_attrs_list()
  end

  describe "get_all/3" do
    test "should filter by name" do
      result =
      "Joe"
      |> Queries.get_all("","")
      |> Repo.all()

      assert Enum.at(result, 0).player_name == "Joe Banyard"
    end

    test "should sort by total rushing yards desc" do
      result =
      ""
      |> Queries.get_all("total_rushing_yards","desc")
      |> Repo.all()

      assert Enum.at(result, 0).total_rushing_yards == 1043
      assert Enum.at(result, 0).player_name == "Mark Ingram"
    end

    test "should sort by total rushing touchdowns" do
      result =
      ""
      |> Queries.get_all("total_rushing_touchdowns","desc")
      |> Repo.all()

      assert Enum.at(result, 0).total_rushing_touchdowns == 9
      assert Enum.at(result, 0).player_name == "Jeremy Hill"
    end

    test "should sort by longest rush desc" do
      result =
      ""
      |> Queries.get_all("longest_rush","desc")
      |> Repo.all()

      assert Enum.at(result, 0).longest_rush == 75
      assert Enum.at(result, 0).player_name == "Mark Ingram"
    end

    test "should return all records" do
      result = ""
      |> Queries.get_all("","")
      |> Repo.all()

      assert Enum.count(result) == 15
    end
  end
end
