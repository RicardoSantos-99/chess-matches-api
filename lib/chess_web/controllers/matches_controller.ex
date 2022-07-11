defmodule ChessWeb.MatchesController do
  use ChessWeb, :controller

  def index(conn, params) do
    matches =
      Mongo.find(:mongo, "chess", params)
      |> Enum.to_list()
      |> Enum.map(&Map.delete(&1, "_id"))

    conn
    |> json(matches)
  end
end
