defmodule Widgets.Mailer do
  @moduledoc """
  The Mailer takes care of creating emails
  """
  use Mailgun.Client,
    domain: Application.get_env(:hello_phoenix, :mailgun_domain),
    key: Application.get_env(:hello_phoenix, :mailgun_key)

  # mode: :test,
  # test_file_path: "/tmp/mailgun.json"

  def send_order_confirmation(email, id) do
    send_email(
      to: email,
      from: "us@example.com",
      subject: "Confirming your order number #{id}",
      html: confirm_html(id)
    )
  end

  defp confirm_html(id) do
    Phoenix.View.render_to_string(WidgetsWeb.EmailView, "confirmation.html", %{widget_id: id})
  end
end
