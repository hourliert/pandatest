defmodule PandatestWeb.PageController do
  use PandatestWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
