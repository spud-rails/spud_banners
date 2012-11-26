class SpudBanner < ActiveRecord::Base
  attr_accessible :banner, :link_to, :link_to_class, :title, :alt, :sort_order, :target
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
end
