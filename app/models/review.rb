class Review < ApplicationRecord
 belongs_to :category
 has_many :likes, dependent: :destroy
 has_rich_text :content
end
