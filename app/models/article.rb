class Article < ApplicationRecord
  has_many :comments 
  has_many :taggings 
  has_many :tags,through: :taggings 

   has_attached_file :image 
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def  tag_list 
    #self.tags.collect{|tag| tag.name}.join(",")
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end 

  def tag_list=(tag_string)
    tags = tag_string.split(",").collect{|s| s.downcase}.uniq 
    old_or_new_tags = tags.collect{|tag| Tag.find_or_create_by(name: tag)}
    self.tags = old_or_new_tags 
  end 



end
