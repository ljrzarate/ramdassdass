class PageImageGenerator
  attr_reader :generator, :instace

  def initialize(instace:, generator:)
    @generator = generator
    @instace   = instace
  end

  def show_on_main_banner
    generator.
    new(instace: instace).
    show_on_main_banner
  end
end