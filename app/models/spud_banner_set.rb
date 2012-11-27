class SpudBannerSet < ActiveRecord::Base
  attr_accessible :cropped, :height, :name, :short_name, :width
  has_many :banners, :class_name => 'SpudBanner', :order => 'sort_order asc', :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_numericality_of :width, :height

  def self.find_by_identifier(identifier)
    if identifier.class == String
      banner_set = SpudBannerSet.find_by_name(identifier)
    elsif identifier.class == Symbol
      banner_set = SpudBannerSet.find_by_name(identifier.to_s.titleize)
    else
      banner_set = SpudBannerSet.find(identifier)
    end
    return banner_set
  end

  def reprocess_banners!
    self.banners.each do |banner|
      banner.banner.reprocess!
    end
  end

  def set_name
    return name
  end

end
