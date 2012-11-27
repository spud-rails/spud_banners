class SpudBanner < ActiveRecord::Base
  attr_accessible :banner, :link_to, :link_target, :title, :alt, :sort_order
  belongs_to :owner, :class_name => 'SpudBannerSet', :foreign_key => 'spud_banner_set_id'

  has_attached_file :banner, 
    :styles => lambda { |attachment| attachment.instance.dynamic_styles },
    :convert_options => {
      :admin_small => '-strip -density 72x72',
      :banner => '-strip -density 72x72'
    },
    :storage => Spud::Banners.paperclip_storage,
    :s3_credentials => Spud::Banners.s3_credentials,
    :url => Spud::Banners.storage_url,
    :path => Spud::Banners.storage_path

  validates_attachment_presence :banner

  def dynamic_styles
    styles = {
      :spud_admin_small => '300x150'
    }
    owner_style = nil
    if self.owner
      owner_style = "#{self.owner.width}x#{self.owner.height}"
      owner_style += '#' if self.owner.cropped
      styles[:banner] = owner_style
    end
    return styles
  end

  def self.banners_for_set(identifier)
    case identifier.class
      when String
        banner_set = SpudBannerSet.find_by_name(identifier)
      when Symbol
        banner_set = SpudBannerSet.find_by_name(identifier.to_s.titleize)
      when Number
        banner_set = SpudBannerSet.find(identifier)
    end
    if banner_set
      return banner_set.banners
    else
      return []
    end
  end

  def set_name
    return owner.name
  end

end
