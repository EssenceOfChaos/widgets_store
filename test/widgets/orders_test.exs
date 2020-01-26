defmodule Widgets.OrdersTest do
  use Widgets.DataCase

  alias Widgets.Orders

  describe "widgets" do
    alias Widgets.Orders.Widget

    @valid_attrs %{color: "some color", date: ~N[2010-04-17 14:00:00], quantity: 42, type: "some type"}
    @update_attrs %{color: "some updated color", date: ~N[2011-05-18 15:01:01], quantity: 43, type: "some updated type"}
    @invalid_attrs %{color: nil, date: nil, quantity: nil, type: nil}

    def widget_fixture(attrs \\ %{}) do
      {:ok, widget} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Orders.create_widget()

      widget
    end

    test "list_widgets/0 returns all widgets" do
      widget = widget_fixture()
      assert Orders.list_widgets() == [widget]
    end

    test "get_widget!/1 returns the widget with given id" do
      widget = widget_fixture()
      assert Orders.get_widget!(widget.id) == widget
    end

    test "create_widget/1 with valid data creates a widget" do
      assert {:ok, %Widget{} = widget} = Orders.create_widget(@valid_attrs)
      assert widget.color == "some color"
      assert widget.date == ~N[2010-04-17 14:00:00]
      assert widget.quantity == 42
      assert widget.type == "some type"
    end

    test "create_widget/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_widget(@invalid_attrs)
    end

    test "update_widget/2 with valid data updates the widget" do
      widget = widget_fixture()
      assert {:ok, %Widget{} = widget} = Orders.update_widget(widget, @update_attrs)
      assert widget.color == "some updated color"
      assert widget.date == ~N[2011-05-18 15:01:01]
      assert widget.quantity == 43
      assert widget.type == "some updated type"
    end

    test "update_widget/2 with invalid data returns error changeset" do
      widget = widget_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_widget(widget, @invalid_attrs)
      assert widget == Orders.get_widget!(widget.id)
    end

    test "delete_widget/1 deletes the widget" do
      widget = widget_fixture()
      assert {:ok, %Widget{}} = Orders.delete_widget(widget)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_widget!(widget.id) end
    end

    test "change_widget/1 returns a widget changeset" do
      widget = widget_fixture()
      assert %Ecto.Changeset{} = Orders.change_widget(widget)
    end
  end
end
