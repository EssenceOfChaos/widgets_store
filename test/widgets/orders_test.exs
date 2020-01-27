defmodule Widgets.OrdersTest do
  @moduledoc """
  Testing the Orders context
  """
  use Widgets.DataCase

  alias Widgets.Orders

  describe "widgets" do
    alias Widgets.Orders.Widget

    @valid_attrs %{
      color: "RED",
      date: ~D[2021-12-25],
      quantity: 4,
      type: "WIDGET",
      status: "PENDING",
      email: "someguy@aol.com"
    }

    @update_attrs %{
      color: "BLUE",
      date: ~D[2021-12-26],
      quantity: 2,
      type: "WIDGET_XTREME",
      status: "FULFILLED",
      email: "someguy2@aol.com"
    }

    @invalid_attrs %{color: nil, date: nil, quantity: nil, type: nil, email: nil}

    @invalid_color %{
      color: "BROWN",
      date: ~D[2021-12-25],
      quantity: 4,
      type: "WIDGET",
      status: "PENDING"
    }

    @invalid_type %{
      color: "YELLOW",
      date: ~D[2021-12-25],
      quantity: 4,
      type: "SUPER",
      status: "PENDING"
    }

    @invalid_date %{
      color: "BLUE",
      date: Date.utc_today(),
      quantity: 1,
      type: "WIDGET_PRO",
      status: "PENDING"
    }

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

    # Attempt to create a widget of color "BROWN"
    test "create_widget/1 with invalid color returns correct error message" do
      assert {:error, changeset} = Orders.create_widget(@invalid_color)
      assert changeset.errors[:color] == {"Widgets can only be ordered in primary colors.", []}
    end

    # Attempt to create a widget of type "SUPER"
    test "create_widget/1 with invalid type returns correct error message" do
      assert {:error, changeset} = Orders.create_widget(@invalid_type)

      assert changeset.errors[:type] ==
               {"Available widget types include Widget, Widget Pro, and Widget Xtreme.", []}
    end

    # Attempt to create a widget using todays date
    test "create_widget/1 with invalid date returns correct error message" do
      assert {:error, changeset} = Orders.create_widget(@invalid_date)

      assert changeset.errors[:date] ==
               {"Widget orders must be placed at least one week in advance.", []}
    end

    test "create_widget/1 with valid data creates a widget" do
      assert {:ok, %Widget{} = widget} = Orders.create_widget(@valid_attrs)
      assert widget.color == "RED"
      assert widget.date == ~D[2021-12-25]
      assert widget.quantity == 4
      assert widget.type == "WIDGET"
      assert widget.status == "PENDING"
    end

    test "create_widget/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_widget(@invalid_attrs)
    end

    test "update_widget/2 with valid data updates the widget" do
      widget = widget_fixture()
      assert {:ok, %Widget{} = widget} = Orders.update_widget(widget, @update_attrs)
      assert widget.color == "BLUE"
      assert widget.date == ~D[2021-12-26]
      assert widget.quantity == 2
      assert widget.type == "WIDGET_XTREME"
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
