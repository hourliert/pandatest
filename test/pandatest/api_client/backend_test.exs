defmodule Pandatest.ApiClient.BackendTest do
  use Pandatest.DataCase
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe "backend" do
    alias Pandatest.ApiClient.Backend

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
  end
end
