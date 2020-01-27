defmodule Widgets.Mailer do
  @moduledoc """
  The Mailer takes care of sending emails. All the functionality we need is included by the 'use' macro
  """

  use Bamboo.Mailer, otp_app: :widgets
end
