class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :group
      t.string :name
      t.text :body
      t.integer :rating
      t.string :created_by
      t.integer :likes

      t.timestamps
    end
  end
end
