class Shelves::PageImageGenerator
  attr_reader :instace

  def initialize(instace:)
    @instace = instace
  end

  def show_on_main_banner
    nil
  end

end