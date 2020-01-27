defmodule Widgets.Orders.Widget do
  @moduledoc """
    The Widget Model. Represents a widget order.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @valid_colors ["RED", "YELLOW", "BLUE"]
  @valid_types ["WIDGET", "WIDGET_PRO", "WIDGET_XTREME"]

  schema "widgets" do
    field :color, :string
    field :date, :date
    field :quantity, :integer
    field :type, :string
    field :status, :string

    timestamps()
  end

  @doc """
  Creates a Widget order changeset to retain data integrity
  """
  def changeset(widget, attrs) do
    widget
    |> cast(attrs, [:quantity, :color, :date, :type, :status])
    |> validate_required([:quantity, :color, :date, :type])
    |> validate_number(:quantity, greater_than_or_equal_to: 1)
    |> validate_color(:color)
    |> validate_type(:type)
    |> validate_date()
  end

  ## Private Functions ##

  # helper function to validate :color
  defp validate_color(changeset, color) do
    validate_change(changeset, color, fn :color, color ->
      if !Enum.member?(@valid_colors, color) do
        [{:color, "Widgets can only be ordered in primary colors."}]
      else
        []
      end
    end)
  end

  # helper function to validate :type
  defp validate_type(changeset, type) do
    validate_change(changeset, type, fn :type, type ->
      if !Enum.member?(@valid_types, type) do
        [{:type, "Available widget types include Widget, Widget Pro, and Widget Xtreme."}]
      else
        []
      end
    end)
  end

  # helper function to validate :date
  defp validate_date(changeset) do
    validate_change(changeset, :date, fn _, date ->
      today = Date.utc_today()
      available_date = Date.add(today, 7)

      case Date.compare(date, available_date) do
        :lt -> [date: "Widget orders must be placed at least one week in advance."]
        _ -> []
      end
    end)
  end
end
