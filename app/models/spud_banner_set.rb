class SpudBannerSet < ActiveRecord::Base
  has_many :banners, -> { order :sort_order }, :class_name => 'SpudBanner', :dependent => :destroy, :inverse_of => :owner

  validates :name, :presence => true, :uniqueness => true
  validates :width, :numericality => true
  validates :height, :numericality => true

  after_destroy :expire_cache
  after_save    :expire_cache

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

  def expire_cache
    if defined?(Spud::Cms)
      old_name = self.name_was
      values = [self.name]
      values << old_name if !old_name.blank?
      SpudPageLiquidTag.where(:tag_name => ["spud_banner_set","banner_set"], :value => values).includes(:attachment).each do |tag|
        partial = tag.touch
      end
    end
  end

end
