# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NflRushing.Repo.insert!(%NflRushing.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias NflRushing.Integration.PlayerRushing, as: Integrator
alias NflRushing.PlayerRushing.Service

"priv/data/rushing.json"
|> Integrator.read_json_data()
|> Integrator.create_map_list_from_json()
|> Service.create_player_rushings_from_attrs_list()
