defmodule WidgetsWeb.PageController do
  use WidgetsWeb, :controller

  def index(conn, _params) do
    IO.inspect("App environment: '#{Application.get_env(:widgets, :env)}'")
    render(conn, "index.html")
  end
end
