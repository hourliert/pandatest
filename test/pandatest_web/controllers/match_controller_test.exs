defmodule PandatestWeb.MatchControllerTest do
  use PandatestWeb.ConnCase

  test "GET /matches/:id/winning_probabilities with a valid match id", %{conn: conn} do
    conn = get(conn, "/matches/match_with_opponents_for_win_probabilities/winning_probabilities")

    assert json_response(conn, 200)["data"] == %{
             "Baecon" => 0.333,
             "Fnatic" => 0.667
           }
  end

  test "GET /matches/:id/winning_probabilities with an invalid match id", %{conn: conn} do
    conn = get(conn, "/matches/unknown/winning_probabilities")

    assert json_response(conn, 200)["error"] == true
  end
end
