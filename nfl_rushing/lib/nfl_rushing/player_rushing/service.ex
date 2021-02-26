defmodule NflRushing.PlayerRushing.Service do
  alias NflRushing.PlayerRushing
  alias NflRushing.PlayerRushing.Queries
  alias NflRushing.Repo
  alias NflRushing.Utils.Pagination
  
  @spec list_player_rushings(String.t(), String.t(), String.t(), String.t() | number, String.t() | non_neg_integer) ::
          %{
            count: number,
            current_page: number,
            first: number,
            first_page: 1,
            has_next: boolean,
            has_prev: boolean,
            items: [PlayerRushing],
            last: number,
            last_page: integer,
            next_page: number,
            prev_page: number
          }
  def list_player_rushings(player_name, order_by, direction, page_number, page_size) do
    player_name
    |> Queries.get_all(order_by, direction)
    |> Pagination.page(page_number, page_size)
  end

  @spec list_player_rushings_to_download(String.t(), String.t(), String.t()) :: [PlayerRushing]
  def list_player_rushings_to_download(player_name, order_by, direction) do
    player_name
    |> Queries.get_all(order_by, direction)
    |> Repo.all()
  end

  @spec create_player_rushings_from_attrs_list([map()]) :: :ok
  def create_player_rushings_from_attrs_list(list) do
    changeset_list =
    Enum.map(list, fn attrs ->
      %PlayerRushing{}
      |> PlayerRushing.changeset(attrs)
    end)

    Enum.each(changeset_list, fn entity -> Repo.insert!(entity) end)
  end

end
