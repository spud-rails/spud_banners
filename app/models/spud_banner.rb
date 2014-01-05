class SpudBanner < ActiveRecord::Base
  belongs_to :owner, :class_name => 'SpudBannerSet', :foreign_key => 'spud_banner_set_id', :inverse_of => :banners, :touch => true

  has_attached_file :banner,
    :styles => lambda { |attachment| attachment.instance.dynamic_styles },
    :convert_options => {
      :admin_small => '-strip -density 72x72',
      :banner => '-strip -density 72x72'
    },
    :storage => Spud::Banners.paperclip_storage,
    :s3_credentials => Spud::Banners.s3_credentials,
    :s3_host_name => Spud::Banners.s3_host_name,
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

  def set_name
    return owner.name
  end

end
