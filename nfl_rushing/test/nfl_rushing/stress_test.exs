defmodule NflRushing.StressTest do
  alias NflRushing.Integration.PlayerRushing, as: Integrator
  alias NflRushing.PlayerRushing.Queries
  alias NflRushing.PlayerRushing.Service
  alias NflRushing.Repo

  use NflRushing.DataCase

  setup do

    "priv/data/stress.json"
    |> Integrator.read_json_data()
    |> Integrator.create_map_list_from_json()
    |> Service.create_player_rushings_from_attrs_list()
  end

  describe "get_all/3" do
    test "should return all records" do
      result = ""
      |> Queries.get_all("","")
      |> Repo.all()

      assert Enum.count(result) == 10758
    end
  end
end
