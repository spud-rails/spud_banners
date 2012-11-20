class SpudBanner < ActiveRecord::Base
  attr_accessible :link_to, :link_to_class, :order, :spud_banner_set_id, :target
  belongs_to :owner, :class_name => 'SpudBannerSet'

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

  def dynamic_styles    
    owner_style = "#{self.owner.width}x#{self.owner.height}"
    owner_style += '#' if self.owner.cropped
    return {
      :admin_small => '100x100#',
      :banner => owner_style
    }
  end
end
