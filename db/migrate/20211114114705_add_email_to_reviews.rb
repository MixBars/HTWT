class AddEmailToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :authorEmail, :string
  end
end
