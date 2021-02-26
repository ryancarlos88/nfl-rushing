defmodule NflRushing.Adapter.PlayerRushing do

  def create_entity_params_from_map(%{
    "Player": player,
    "Team": team,
    "Pos": pos,
    "Att": att,
    "Att/G": attg,
    "Yds": yds,
    "Avg": avg,
    "Yds/G": ydsg,
    "TD": td,
    "Lng": lng,
    "1st": first,
    "1st%": firstpct,
    "20+": twentyp,
    "40+": fourtyp,
    "FUM": fum
  }) do

    {longest_rush, touchdown_occurred} = sanitize_longest_rush(lng)

    %{
      longest_rush: longest_rush,
      player_name: player,
      player_position: pos,
      player_team: team,
      rushing_20p_yards_each: twentyp,
      rushing_40p_yards_each: fourtyp,
      rushing_attemps: att,
      rushing_attempts_per_game_avg: attg,
      rushing_avg_yards_per_attempt: avg,
      rushing_first_downs: first,
      rushing_first_downs_percentage: firstpct,
      rushing_fumbles: fum,
      rushing_yards_per_game: ydsg,
      total_rushing_touchdowns: td,
      total_rushing_yards: sanitize_total_rushing_yards(yds),
      touchdown_occurred: touchdown_occurred == "T",
    }
  end

  defp sanitize_longest_rush(lng) when is_integer(lng), do: {lng, ""}
  defp sanitize_longest_rush(lng) when is_binary(lng), do: Integer.parse(lng)

  defp sanitize_total_rushing_yards(yds) when is_integer(yds), do: yds
  defp sanitize_total_rushing_yards(yds) when is_binary(yds) do
    yds
    |> String.replace(",","")
    |> String.to_integer()
  end
end
