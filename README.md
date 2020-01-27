# Widgets

To run this application you will need to have [Elixir](https://elixir-lang.org/install.html) and [Phoenix](https://hexdocs.pm/phoenix/installation.html) installed on your machine.

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `cd assets && npm install`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Result of sending email

[debug] Sending email with Bamboo.MailgunAdapter:

```json
%Bamboo.Email{assigns: %{}, attachments: [], bcc: [], cc: [], from: {nil, "us@example.com"}, headers: %{}, html_body: "<div class=\"jumbotron\">\n  <h2>Your order has been confirmed!</h2>\n  <p> Your order number is 4</p>\n  <span><a href=\"/widgets/4\">View Order</a></span>\n</div>\n", private: %{}, subject: "Order Confirmation", text_body: "Thanks for ordering!", to: [nil: "fjschiller@gmail.com"]}
```
