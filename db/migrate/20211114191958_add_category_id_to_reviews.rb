class AddCategoryIdToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :category_id, :integer
  end
end
