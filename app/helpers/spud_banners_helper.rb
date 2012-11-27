module SpudBannersHelper

  def spud_banners_for_set(set_or_identifier, options = {})
    if set_or_identifier.is_a?(SpudBannerSet)
      banner_set = set_or_identifier
    else
      banner_set = SpudBannerSet.find_by_identifier(set_or_identifier)
    end
    return '' if banner_set.blank?
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
      spud_banner_image_tag(banner)
    else
      link_to(banner.link_to, :target => banner.target) do
        spud_banner_image_tag(banner)
      end
    end
  end

  def spud_banner_image_tag(banner)
    image_tag(banner.banner.url(:banner), :alt => banner.alt, :title => banner.title)
  end

end