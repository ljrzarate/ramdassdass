class Posts::PageImageGenerator
  attr_reader :instace

  def initialize(instace:)
    @instace = instace
  end

  def show_on_main_banner
    image_to_show_on_main_banner
  end

  private

  def image_to_show_on_main_banner
    return instace.main_image if instace.is_box? # it is the parent box
    return instace.main_image if !instace.is_box? && instace.parent_box_id.blank? # it is a single post with no box
    return instace.parent_box.main_image if !instace.is_box? # it is a child post - it has a box
  end
end