class Review < ApplicationRecord
 belongs_to :category
 has_many :likes, dependent: :destroy
end
