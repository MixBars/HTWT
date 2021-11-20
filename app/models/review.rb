require 'elasticsearch/model'
class Review < ApplicationRecord
 include Elasticsearch::Model
 include Elasticsearch::Model::Callbacks
 has_rich_text :content



 belongs_to :category
 has_many :likes, dependent: :destroy
 has_many :user_rating, dependent: :destroy
 

 

 
end
