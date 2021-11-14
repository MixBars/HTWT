class ModifyCategories < ActiveRecord::Migration[6.1]
  def change
    add_index :categories, :name, unique: true
    Category.create :name => 'Movies'
    Category.create :name => 'Series'
    Category.create :name => 'Books'
    Category.create :name => 'Games'
  end
end
