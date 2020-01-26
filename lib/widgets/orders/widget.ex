defmodule Widgets.Orders.Widget do
  @moduledoc """
    The Widget Model. Represents a widget order.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "widgets" do
    field :color, :string
    field :date, :naive_datetime
    field :quantity, :integer
    field :type, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(widget, attrs) do
    widget
    |> cast(attrs, [:quantity, :color, :date, :type, :status])
    |> validate_required([:quantity, :color, :date, :type])
  end
end
