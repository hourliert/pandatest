defmodule Pandatest.MatchesTest do
  use Pandatest.DataCase

  alias Pandatest.Matches
  alias Pandatest.Matches.Match
  alias Pandatest.Opponents.{Opponent, Player}

  describe "matches" do
    test "get_match/1 returns the match details" do
      assert Matches.get_match("match_with_opponents") ==
               %Match{
                 id: "match_with_opponents",
                 name: "Rhyno vs Baecon",
                 scheduled_at: ~U[2020-10-10 14:10:10Z],
                 opponents: [
                   %Opponent{type: "Player", opponent: %Player{id: "thomas", name: "Thomas"}},
                   %Opponent{type: "Player", opponent: %Player{id: "leo", name: "Leo"}}
                 ]
               }
    end

    test "get_match/1 fails because of server error" do
      assert {:error, _} = Matches.get_match("match_with_server_error")
    end

    test "upcoming_matches/0 returns the 5 first upcoming_matches" do
      assert Matches.upcoming_matches() == [
               %Pandatest.Matches.Match{
                 id: 1,
                 name: "Rhyno vs Baecon",
                 scheduled_at: ~U[2020-10-10 14:10:10Z],
                 opponents: []
               },
               %Pandatest.Matches.Match{
                 id: 2,
                 name: "Cloud9 vs MSI",
                 scheduled_at: ~U[2020-10-10 14:10:10Z],
                 opponents: []
               },
               %Pandatest.Matches.Match{
                 id: 3,
                 name: "Fnatic vs HyperX",
                 scheduled_at: ~U[2020-10-10 15:10:10Z],
                 opponents: []
               },
               %Pandatest.Matches.Match{
                 id: 4,
                 name: "Light vs Flash",
                 scheduled_at: ~U[2020-10-10 15:10:10Z],
                 opponents: []
               },
               %Pandatest.Matches.Match{
                 id: 5,
                 name: "Xbox vs Underdog",
                 scheduled_at: ~U[2020-10-10 16:10:10Z],
                 opponents: []
               }
             ]
    end

    test "upcoming_matches/0 fails because of server error" do
      assert {:error, _} = Matches.upcoming_matches("with_error")
    end

    test "winning_probabilities_for_match/1 returns the winning probablities for a match" do
      # Fnatic win ratio: 0.66
      # Baecon win ratio: 0.33
      # P(Fnatic Win) = (0.66 + (1 - 0.33)) / 2
      # P(Baecon Win) = ((1 - 0.66) + 0.33) / 2
      assert Matches.winning_probabilities_for_match("match_with_opponents_for_win_probabilities") ==
               %{"Baecon" => 0.333, "Fnatic" => 0.667}
    end

    test "winning_probabilities_for_match/1 returns the winning probablities for a match when a team is new" do
      # Fnatic win ratio: 0.66
      # Newcomer win ratio: 0.5
      # P(Fnatic Win) = (0.66 + (1 - 0.5)) / 2
      # P(Newcomer Win) = ((1 - 0.66) + 0.5) / 2
      assert Matches.winning_probabilities_for_match(
               "match_with_new_opponents_for_win_probabilities"
             ) ==
               %{"Fnatic" => 0.584, "Newcomer" => 0.416}
    end

    test "winning_probabilities_for_match/1 returns the winning probablities for a match with 3 opponents" do
      # Fnatic win ratio: 0.66
      # Baecon win ratio: 0.33
      # Newcomer win ratio: 0.5
      # P(Fnatic Win) = (0.66 + (1 - 0.33) + (1 - 0.5)) / 3
      # P(Baecon Win) = ((1 - 0.66) + 0.33 + (1 - 0.5)) / 3
      # P(Newcomer Win) = ((1 - 0.66) + (1 - 0.33) + 0.5) / 3
      assert Matches.winning_probabilities_for_match(
               "match_with_three_opponents_for_win_probabilities"
             ) ==
               %{"Fnatic" => 0.611, "Newcomer" => 0.5, "Baecon" => 0.389}
    end

    test "winning_probabilities_for_match/1 fails when the get_match API has an error" do
      assert {:error, _} = Matches.winning_probabilities_for_match("match_with_server_error")
    end
  end
end
