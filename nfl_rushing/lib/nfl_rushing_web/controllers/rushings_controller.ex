defmodule NflRushingWeb.RushingsController do
  alias CSV
  alias NflRushing.PlayerRushing
  alias NflRushing.PlayerRushing.Service

  use NflRushingWeb, :controller


  @spec index(Plug.Conn.t(), nil | maybe_improper_list | map) :: Plug.Conn.t()
  def index(conn, params) do
    player_name = params["player_name"] || ""
    sort = params["sort"] || ""
    page_number = params["page_number"] || 1
    page_size = params["page_size"] || 20
    direction = params["direction"] || "asc"
    rushings = Service.list_player_rushings(player_name, sort, direction, page_number, page_size)

    arrow_yds = if sort == "total_rushing_yards" and direction == "asc" do "desc" else "asc" end
    arrow_td = if sort == "total_rushing_touchdowns" and direction == "asc" do "desc" else "asc" end
    arrow_lng = if sort == "longest_rush" and direction == "asc" do "desc" else "asc" end

    rushings =
      rushings
        |> Map.put(:arrow_yds, arrow_yds)
        |> Map.put(:arrow_td, arrow_td)
        |> Map.put(:arrow_lng, arrow_lng)

    render(conn, "index.html", rushings: rushings)
  end

  @spec download(Plug.Conn.t(), nil | maybe_improper_list | map) :: Plug.Conn.t()
  def download(conn, params) do
    player_name = params["player_name"] || ""
    sort = params["sort"] || ""
    direction = params["direction"] || "asc"

    csv =
      player_name
      |> Service.list_player_rushings_to_download(sort, direction)
      |> prepare_rushings_to_csv()


    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"player_rushings.csv\"")
    |> send_resp(200, csv)
  end

  @spec prepare_rushings_to_csv([PlayerRushing]) :: String.t()
  def prepare_rushings_to_csv(rushings) do
    rushings
    |> Stream.map(fn r -> Map.drop(r, [:__meta__, :__struct__, :id, :inserted_at, :updated_at]) end)
    |> CSV.Encoding.Encoder.encode(headers: true)
    |> Enum.to_list
    |> to_string
  end
end
