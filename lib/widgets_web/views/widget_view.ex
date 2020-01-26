defmodule WidgetsWeb.WidgetView do
  use WidgetsWeb, :view

  def today() do
    Date.utc_today()
  end
end
