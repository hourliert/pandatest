defmodule Pandatest.OpponentsTest do
  use Pandatest.DataCase

  alias Pandatest.Opponents
  alias Pandatest.Matches.Match
  alias Pandatest.Opponents.Opponent

  def mock_opponent(type, id) do
    %Opponent{
      type: type,
      opponent: %{
        id: id
      }
    }
  end

  def mock_match(id, winner_id, opponents) do
    %Match{
      id: id,
      name: "a-match-#{id}",
      opponents: opponents,
      winner_id: winner_id
    }
  end

  describe "opponents" do
    test "load_opponent_matches/1 returns the opponent match, for a player" do
      opponent = mock_opponent("Player", "thomas")

      assert Opponents.load_opponent_matches(opponent) ==
               %{
                 opponent
                 | matches: [
                     %Match{
                       id: 1,
                       name: "Thomas vs Leo",
                       scheduled_at: ~U[2020-10-10 14:10:10Z],
                       opponents: []
                     }
                   ]
               }
    end

    test "load_opponent_matches/1 fails when the API returns an error, for a player" do
      opponent = mock_opponent("Player", "id_with_error")
      assert Opponents.load_opponent_matches(opponent) == %{opponent | matches: []}
    end

    test "load_opponent_matches/1 returns the opponent match, for a team" do
      opponent = mock_opponent("Team", "rhyno")

      assert Opponents.load_opponent_matches(opponent) ==
               %{
                 opponent
                 | matches: [
                     %Match{
                       id: 1,
                       name: "Rhyno vs Baecon",
                       scheduled_at: ~U[2020-10-10 14:10:10Z],
                       opponents: []
                     }
                   ]
               }
    end

    test "load_opponent_matches/1 fails when the API returns an error, for a team" do
      opponent = mock_opponent("Team", "id_with_error")
      assert Opponents.load_opponent_matches(opponent) == %{opponent | matches: []}
    end

    test "compute_opponent_win_ratio/1 computes the opponent win ratio when they have matches" do
      opponent = mock_opponent("Player", "thomas")
      other_opponent = mock_opponent("Player", "leo")

      matches = [
        # Player 1 won
        mock_match(1, opponent.opponent.id, [
          opponent,
          other_opponent
        ]),
        # Player 1 won
        mock_match(2, opponent.opponent.id, [
          opponent,
          other_opponent
        ]),
        # Player 2 won
        mock_match(3, other_opponent.opponent.id, [
          opponent,
          other_opponent
        ])
      ]

      opponent = %{opponent | matches: matches}

      assert Opponents.compute_opponent_win_ratio(opponent) == %{opponent | win_ratio: 0.667}
    end

    test "compute_opponent_win_ratio/1 computes the opponent win ratio when they don't have matche" do
      opponent = mock_opponent("Player", "thomas")
      matches = []

      opponent = %{opponent | matches: matches}

      assert Opponents.compute_opponent_win_ratio(opponent) == %{opponent | win_ratio: 0.5}
    end
  end
end
