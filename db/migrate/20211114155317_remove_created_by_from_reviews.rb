class RemoveCreatedByFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :created_by, :string
  end
end
