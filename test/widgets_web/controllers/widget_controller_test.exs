defmodule WidgetsWeb.WidgetControllerTest do
  @moduledoc """
  Testing the Widgets Controller
  """
  use WidgetsWeb.ConnCase

  alias Widgets.Orders

  @create_attrs %{
    color: "RED",
    date: ~D[2021-12-25],
    quantity: 42,
    type: "WIDGET_PRO",
    status: "PENDING",
    email: "someguy@aol.com"
  }
  @update_attrs %{
    color: "YELLOW",
    date: ~D[2021-12-26],
    quantity: 53,
    type: "WIDGET_XTREME",
    status: "FULFILLED",
    email: "someguy2@aol.com"
  }
  @invalid_attrs %{color: nil, date: nil, quantity: nil, type: nil}

  def fixture(:widget) do
    {:ok, widget} = Orders.create_widget(@create_attrs)
    widget
  end

  describe "index" do
    test "lists all widgets", %{conn: conn} do
      conn = get(conn, Routes.widget_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Widget Orders"
    end
  end

  describe "new widget" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.widget_path(conn, :new))
      assert html_response(conn, 200) =~ "New Widget Order"
    end
  end

  describe "create widget" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.widget_path(conn, :create), widget: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.widget_path(conn, :show, id)

      conn = get(conn, Routes.widget_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Widget Order"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.widget_path(conn, :create), widget: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Widget Order"
    end
  end

  describe "edit widget" do
    setup [:create_widget]

    test "renders form for editing chosen widget", %{conn: conn, widget: widget} do
      conn = get(conn, Routes.widget_path(conn, :edit, widget))
      assert html_response(conn, 200) =~ "Edit Widget"
    end
  end

  describe "update widget" do
    setup [:create_widget]

    test "redirects when data is valid", %{conn: conn, widget: widget} do
      conn = put(conn, Routes.widget_path(conn, :update, widget), widget: @update_attrs)
      assert redirected_to(conn) == Routes.widget_path(conn, :show, widget)

      conn = get(conn, Routes.widget_path(conn, :show, widget))
      assert html_response(conn, 200) =~ "YELLOW"
    end

    test "renders errors when data is invalid", %{conn: conn, widget: widget} do
      conn = put(conn, Routes.widget_path(conn, :update, widget), widget: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Widget"
    end
  end

  describe "delete widget" do
    setup [:create_widget]

    test "deletes chosen widget", %{conn: conn, widget: widget} do
      conn = delete(conn, Routes.widget_path(conn, :delete, widget))
      assert redirected_to(conn) == Routes.widget_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.widget_path(conn, :show, widget))
      end
    end
  end

  defp create_widget(_) do
    widget = fixture(:widget)
    {:ok, widget: widget}
  end
end
