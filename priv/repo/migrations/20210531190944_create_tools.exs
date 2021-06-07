defmodule Bossabox.Repo.Migrations.CreateTools do
  use Ecto.Migration

  def change do
    create table(:tools) do
      add :title, :string
      add :link, :string
      add :description, :string
      add :tags, {:array, :string}

      timestamps()

    end
  end
end
