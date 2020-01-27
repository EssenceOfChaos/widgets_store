defmodule WidgetsWeb.WidgetController do
  use WidgetsWeb, :controller

  alias Widgets.{Orders, Mailer, Email}
  alias Widgets.Orders.Widget

  def index(conn, _params) do
    widgets = Orders.list_widgets()
    render(conn, "index.html", widgets: widgets)
  end

  def new(conn, _params) do
    changeset = Orders.change_widget(%Widget{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"widget" => widget_params}) do
    case Orders.create_widget(widget_params) do
      {:ok, widget} ->
        Email.confirmation_email(widget.email, widget.id)
        |> Mailer.deliver_now()

        conn
        |> put_flash(:info, "Widget order with ID:#{widget.id} placed successfully!")
        |> redirect(to: Routes.widget_path(conn, :show, widget))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    widget = Orders.get_widget!(id)
    render(conn, "show.html", widget: widget)
  end

  def edit(conn, %{"id" => id}) do
    widget = Orders.get_widget!(id)
    changeset = Orders.change_widget(widget)
    render(conn, "edit.html", widget: widget, changeset: changeset)
  end

  def update(conn, %{"id" => id, "widget" => widget_params}) do
    widget = Orders.get_widget!(id)

    case Orders.update_widget(widget, widget_params) do
      {:ok, widget} ->
        conn
        |> put_flash(:info, "Widget updated successfully.")
        |> redirect(to: Routes.widget_path(conn, :show, widget))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", widget: widget, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    widget = Orders.get_widget!(id)
    {:ok, _widget} = Orders.delete_widget(widget)

    conn
    |> put_flash(:info, "Widget deleted successfully.")
    |> redirect(to: Routes.widget_path(conn, :index))
  end
end
