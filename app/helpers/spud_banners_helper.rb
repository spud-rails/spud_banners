module SpudBannersHelper

  def spud_banners_for_set(identifier, options = {})
    if identifier.class == SpudBannerSet
      banner_set = identifier
    elsif identifier.class == String
      banner_set = SpudBannerSet.find_by_name(identifier)
    elsif identifier.class == Symbol
      banner_set = SpudBannerSet.find_by_name(identifier.to_s.titleize)
    else
      banner_set = SpudBannerSet.find(identifier)
    end
    return if banner_set.blank?
    if block_given?
      banner_set.banners.each do |banner|
        yield(banner)
      end
    else
      content_tag(:div, :class => 'spud_banner_set', 'data-id' => banner_set.id) do
        banner_set.banners.map do |banner|
          concat(content_tag(:div, :class => 'spud_banner_set_banner', 'data-id' => banner.id){ spud_banner_tag(banner) })
        end
      end
    end
  end

  def spud_banner_tag(banner)
    if banner.link_to.blank?
      return image_tag(banner.banner.url(:banner), :alt => banner.alt, :title => banner.title)
    else
      return link_to(banner.link_to, :target => banner.target) do
        image_tag(banner.banner.url(:banner), :alt => banner.alt, :title => banner.title)
      end
    end
  end

end