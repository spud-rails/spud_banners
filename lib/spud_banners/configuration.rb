module Spud
  module Banners
    include ActiveSupport::Configurable
    config_accessor :paperclip_storage, :s3_credentials, :storage_path, :storage_url
    self.paperclip_storage = :filesystem
    self.s3_credentials = "#{Rails.root}/config/s3.yml"
    self.storage_path = ":rails_root/public/system/spud_banners/:id/:style/:basename.:extension"
    self.storage_url = "/system/spud_banners/:id/:style/:basename.:extension"
  end
end