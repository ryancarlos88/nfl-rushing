defmodule NflRushing.PlayerRushing.ServiceTest do
  alias NflRushing.Integration.PlayerRushing, as: Integrator
  alias NflRushing.PlayerRushing.Service

  use NflRushing.DataCase

  setup do
    "priv/data/rushing_sample.json"
    |> Integrator.read_json_data()
    |> Integrator.create_map_list_from_json()
    |> Service.create_player_rushings_from_attrs_list()
  end

  describe "list_player_rushings/5" do
    test "should return all records paginated" do
      result = Service.list_player_rushings("","","",2,5)
      assert result.current_page == 2
      assert result.first_page == 1
      assert result.last_page == 3
      assert result.has_next == true
      assert result.has_prev == true
      assert result.first == 6
      assert result.last == 10
      assert result.prev_page == 1
      assert result.next_page == 3
      assert result.count == 15
    end
  end
end
