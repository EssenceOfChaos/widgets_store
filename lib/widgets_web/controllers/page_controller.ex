defmodule WidgetsWeb.PageController do
  use WidgetsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
