defmodule WidgetsWeb.WidgetControllerTest do
  use WidgetsWeb.ConnCase

  alias Widgets.Orders

  @create_attrs %{color: "some color", date: ~N[2010-04-17 14:00:00], quantity: 42, type: "some type"}
  @update_attrs %{color: "some updated color", date: ~N[2011-05-18 15:01:01], quantity: 43, type: "some updated type"}
  @invalid_attrs %{color: nil, date: nil, quantity: nil, type: nil}

  def fixture(:widget) do
    {:ok, widget} = Orders.create_widget(@create_attrs)
    widget
  end

  describe "index" do
    test "lists all widgets", %{conn: conn} do
      conn = get(conn, Routes.widget_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Widgets"
    end
  end

  describe "new widget" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.widget_path(conn, :new))
      assert html_response(conn, 200) =~ "New Widget"
    end
  end

  describe "create widget" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.widget_path(conn, :create), widget: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.widget_path(conn, :show, id)

      conn = get(conn, Routes.widget_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Widget"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.widget_path(conn, :create), widget: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Widget"
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
      assert html_response(conn, 200) =~ "some updated color"
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
