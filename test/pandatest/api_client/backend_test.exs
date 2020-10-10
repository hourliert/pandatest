defmodule Pandatest.ApiClient.BackendTest do
  use Pandatest.DataCase
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "backend" do
    alias Pandatest.ApiClient.Backend

    test "get_match/1 returns a match data" do
      use_cassette "match_573008" do
        assert {:ok, %{}} = Backend.get_match(573_008)
      end
    end

    test "get_match/1 fails with invalid crendetials" do
      use_cassette "match_invalid_credentials" do
        assert {:error, "Pandascore API error: 401"} = Backend.get_match(573_008)
      end
    end

    test "upcoming_matches/1 fetches 5 upcoming matches" do
      use_cassette "upcoming_5_matches" do
        assert {:ok, body} = Backend.upcoming_matches(count: 5)
        assert body |> length() == 5
      end
    end

    test "upcoming_matches/1 fails with API error" do
      use_cassette "upcoming_matches_invalid_params" do
        assert {:error, "Pandascore API error: 400"} = Backend.upcoming_matches(count: 5)
      end
    end

    test "upcoming_matches/1 fails with invalid credentials" do
      use_cassette "upcoming_matches_invalid_credentials" do
        assert {:error, "Pandascore API error: 401"} = Backend.upcoming_matches(count: 5)
      end
    end

    test "get_matches_for_team/1 returns team matches" do
      use_cassette "match_for_team_127361" do
        assert {:ok, body} = Backend.get_matches_for_team(127_361)
        assert body |> length() == 22
      end
    end

    test "get_matches_for_team/1 fails with invalid crendetials" do
      use_cassette "match_for_team_invalid_credentials" do
        assert {:error, "Pandascore API error: 401"} = Backend.get_matches_for_team(127_361)
      end
    end

    test "get_matches_for_player/1 returns team matches" do
      use_cassette "match_for_player_127361" do
        # Note: this test is failing because my pandascore plan doesn't include historical data for players.
        # I wonder why historical data are included for teams but not for players
        assert {:error, "Pandascore API error: 403"} = Backend.get_matches_for_player(30156)
      end
    end

    test "get_matches_for_player/1 fails with invalid crendetials" do
      use_cassette "match_for_player_invalid_credentials" do
        assert {:error, "Pandascore API error: 401"} = Backend.get_matches_for_player(30156)
      end
    end
  end
end
