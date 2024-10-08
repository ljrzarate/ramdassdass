class Shelves::PageTitleGenerator

  attr_reader :instace

  def initialize(instace:)
    @instace = instace
  end

  def show_on_main_banner
    instace.name
  end

end
