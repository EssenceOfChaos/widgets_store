defmodule WidgetsWeb.PageControllerTest do
  @moduledoc """
  Testing the Page Controller
  """
  use WidgetsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to The Widget Company!"
  end
end
