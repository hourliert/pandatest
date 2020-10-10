defmodule Pandatest.ApiClient do
  @pandascore_client Application.get_env(:pandatest, :pandascore_client)

  def upcoming_matches do
    @pandascore_client.upcoming_matches()
  end
end
