require 'elasticsearch/model'
class Review < ApplicationRecord
 include Elasticsearch::Model
 include Elasticsearch::Model::Callbacks
 has_rich_text :content

 belongs_to :user
 belongs_to :category
 has_many :likes, dependent: :destroy
 has_many :user_rating, dependent: :destroy
 has_many :taggings
 has_many :tags, through: :taggings

 def all_tags
  self.tags.map(&:name).join(', ')
 end

 def all_tags=(names)
  self.tags = names.split(', ').map do |name|
   Tag.where(name: name.strip).first_or_create!
  end
 end
 
 validates :name, :all_tags, presence: true
 validates :content, length: { minimum: 100 }, presence: true

 


end
