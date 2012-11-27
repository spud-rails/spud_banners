class SpudBannerSweeper < ActionController::Caching::Sweeper
  observe :spud_banner, :spud_banner_set

  def before_save(record)
    if record.is_a?(SpudBannerSet)
      @old_name = record.name
    end
  end

  def after_save(record)
    expire_cache_for(record)
  end

  def after_destroy(record)
    expire_cache_for(record)
  end

private

  def expire_cache_for(record)
    # lazy full page cache clear
    cache_path = ActionController::Base.page_cache_directory
    if cache_path != Rails.root && cache_path != Rails.public_path && File.directory?(cache_path)
      FileUtils.rm_rf(cache_path)
    end

    # reprocess cached liquid tags
    if defined?(Spud::Cms)
      values = [record.set_name]
      values << @old_name if !@old_name.blank?
      SpudPageLiquidTag.where(:tag_name => "snippet",:value => values).includes(:attachment).each do |tag|
        partial = tag.attachment
        partial.postprocess_content
        partial.save
        page = partial.try(:spud_page)
        if page.blank? == false
          page.updated_at = Time.now.utc
          page.save
        end
      end
    end
  end

end