class Posts::ByTags
  attr_accessor :tag

  def initialize(tag: nil)
    @tag = tag
  end

  def execute
    Post.tagged_with(tag, on: :tags)
  end
end