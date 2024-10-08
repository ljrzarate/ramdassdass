class Posts::PageTitleGenerator

  attr_reader :instace

  def initialize(instace:)
    @instace = instace
  end

  def show_on_main_banner
    title_to_show_on_main_banner
  end

  private

  def title_to_show_on_main_banner
    return instace.title if instace.is_box?
    return instace.title if !instace.is_box? && instace.parent_box_id.blank?
    return instace.parent_box.title if !instace.is_box?
  end

end
