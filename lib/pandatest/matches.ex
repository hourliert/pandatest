defmodule Pandatest.Matches do
  @moduledoc """
  The Matches context.
  """

  alias Pandatest.ApiClient
  alias Pandatest.Matches.Match

  def upcoming_matches do
    ApiClient.upcoming_matches()
  end
end
