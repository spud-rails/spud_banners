class SpudBannerSet < ActiveRecord::Base
  attr_accessible :cropped, :height, :name, :short_name, :width
  has_many :banners, :class_name => 'SpudBanner', :order => 'sort_order asc', :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_numericality_of :width, :height
end
