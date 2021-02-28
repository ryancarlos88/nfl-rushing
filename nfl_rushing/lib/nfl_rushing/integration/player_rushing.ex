defmodule NflRushing.Integration.PlayerRushing do
  alias CSV
  alias NflRushing.Adapter.PlayerRushing, as: Adapter
  def read_json_data(filename) do
    with {:ok, filebody} <- File.read(filename),
      {:ok, json} <- Jason.decode(filebody) do
     json
    end
  end

  def create_map_list_from_json(json) do
    json
    |> Enum.map(fn map ->
      Map.new( map, fn({key, value}) ->
          {String.to_atom(key), value}
        end
      )
    |> Adapter.create_entity_params_from_map end)

  end

  @spec prepare_rushings_to_csv([any]) :: String.t()
  def prepare_rushings_to_csv(rushings) do
    rushings
    |> Stream.map(fn r -> Map.drop(r, [:__meta__, :__struct__, :id, :inserted_at, :updated_at]) end)
    |> CSV.Encoding.Encoder.encode(headers: true)
    |> Enum.to_list
    |> to_string
  end
end
