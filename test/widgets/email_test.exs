defmodule Widgets.EmailTest do
  use ExUnit.Case

  @valid_order %{
    id: 1,
    color: "RED",
    date: ~D[2021-12-25],
    quantity: 4,
    type: "WIDGET",
    status: "PENDING",
    email: "someguy@aol.com"
  }

  # Testing the creating of emails
  test "confirmation email" do
    email = Widgets.Email.confirmation_email(@valid_order.email, @valid_order.id)
    assert email.to == "someguy@aol.com"
    assert email.from == "us@example.com"
    assert email.text_body =~ "Thanks for ordering!"
    assert email.subject =~ "Order Confirmation"
  end
end
