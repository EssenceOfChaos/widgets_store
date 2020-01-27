defmodule Widgets.Email do
  @moduledoc """
  The Email module defines all the different emails the app can send.
  """
  import Bamboo.Email

  def confirmation_email(email_address, order_id) do
    new_email(
      to: email_address,
      from: "us@example.com",
      subject: "Order Confirmation",
      html_body: confirm_html(order_id),
      text_body: "Thanks for ordering!"
    )
  end

  defp confirm_html(order_id) do
    Phoenix.View.render_to_string(WidgetsWeb.EmailView, "confirmation.html", %{
      widget_id: order_id
    })
  end
end
