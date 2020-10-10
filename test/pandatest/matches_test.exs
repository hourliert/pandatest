defmodule Pandatest.MatchesTest do
  use Pandatest.DataCase

  alias Pandatest.Matches

  describe "matches" do
    alias Pandatest.Matches.{Match, Opponent, Player}

    test "get_match/1 returns the match details" do
      assert Matches.get_match(1) ==
               %Match{
                 id: 1,
                 name: "Rhyno vs Baecon",
                 scheduled_at: ~U[2020-10-10 14:10:10Z],
                 opponents: [
                   %Opponent{type: "player", opponent: %Player{id: 1, name: "Thomas"}},
                   %Opponent{type: "player", opponent: %Player{id: 2, name: "Leo"}}
                 ]
               }
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

    test "winning_probabilities_for_match/1 returns the basic winning probablities for a match" do
      Matches.winning_probabilities_for_match(9493)
      |> IO.inspect()
    end
  end
end
