defmodule PandatestWeb.MatchControllerTest do
  use PandatestWeb.ConnCase

  test "GET /matches/:id/winning_probabilities", %{conn: conn} do
    conn = get(conn, "/matches/match_with_opponents_for_win_probabilities/winning_probabilities")

    assert json_response(conn, 200)["data"] == %{
             "Baecon" => 0.333,
             "Fnatic" => 0.667
           }
  end
end
