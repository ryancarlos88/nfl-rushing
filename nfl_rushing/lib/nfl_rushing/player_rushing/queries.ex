defmodule NflRushing.PlayerRushing.Queries do
  alias NflRushing.PlayerRushing

  import Ecto.Query

  @spec get_all(String.t(), String.t(), String.t()) :: Ecto.Query.t()
  def get_all(player_name, order, direction) do

    base_query()
    |> filter_name(player_name)
    |> sort(order, direction)
  end

  @spec base_query :: Ecto.Query.t()
  def base_query do
    from r in PlayerRushing
  end

  @spec filter_name(Ecto.Query.t(), String.t()) :: Ecto.Query.t()
  def filter_name(query, ""), do: query

  def filter_name(query, player_name) do
    where(query, [r], ilike(r.player_name, ^"%#{player_name}%"))
  end

  @spec sort(Ecto.Query.t(), String.t(), String.t()) :: Ecto.Query.t()
  def sort(query, order, _direction) when order == "", do: query
  def sort(query, order, direction) do
    order_by(query, [r], [{^String.to_atom(direction), field(r, ^String.to_atom(order))}])
  end
end
