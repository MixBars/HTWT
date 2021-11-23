class RemoveAuthorEmailFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :authorEmail, :string
  end
end
