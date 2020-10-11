defmodule PandatestWeb.Router do
  use PandatestWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PandatestWeb do
    pipe_through :api

    get "/matches/:id/winning_probabilities", MatchController, :winning_probabilities
  end
end
