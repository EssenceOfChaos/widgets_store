defmodule Widgets.Repo.Migrations.CreateWidgets do
  use Ecto.Migration

  def change do
    create table(:widgets) do
      add :quantity, :integer
      add :color, :string
      add :date, :date
      add :type, :string
      add :status, :string, default: "Pending"
      add :email, :string
      timestamps()
    end
  end
end
