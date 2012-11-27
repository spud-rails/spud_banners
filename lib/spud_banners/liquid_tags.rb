require 'liquid'
require_relative '../../app/helpers/spud_banners_helper'

module Spud
  module Banners
    class BannerSetTag < Liquid::Tag

      include Sprockets::Helpers::RailsHelper
      include Sprockets::Helpers::IsolatedHelper
      include ActionView::Helpers
      include ActionView::Context
      include SpudBannersHelper

      def initialize(tag_name, set_identifer, tokens)
        @banner_set = SpudBannerSet.find_by_identifier(set_identifer)
      end

      def tag_name
        return 'banner_set'
      end

      def tag_value
        return @banner_set.name
      end

      def render(context)
        return spud_banners_for_set(@banner_set)
      end

    end
  end
end