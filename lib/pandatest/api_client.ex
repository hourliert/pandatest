defmodule Pandatest.ApiClient do
  @pandascore_client Application.get_env(:pandatest, :pandascore_client)

  def upcoming_matches(count: count) do
    @pandascore_client.upcoming_matches(count: count)
  end
end
