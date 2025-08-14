defmodule MattbilbowBlog.Repo.Migrations.CreateCategoriesAndAddToPosts do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, null: false
      add :slug, :string, null: false

      timestamps()
    end

    create unique_index(:categories, [:slug])

    alter table(:posts) do
      add :category_id, references(:categories, on_delete: :nilify_all)
    end

    create index(:posts, [:category_id])

    execute """
            INSERT INTO categories (name, slug, inserted_at, updated_at) VALUES
            ('Engineering', 'engineering', NOW(), NOW()),
            ('Design', 'design', NOW(), NOW()),
            ('Gaming', 'gaming', NOW(), NOW()),
            ('Life', 'life', NOW(), NOW()),
            ('Other', 'other', NOW(), NOW())
            """, ""
  end
end