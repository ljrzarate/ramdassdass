class Posts::ByTags
  attr_accessor :tag, :scope

  def initialize(tag: nil, scope: nil)
    @tag = tag
    @scope = scope
  end

  def execute
    return scope.tagged_with(tag, on: :tags) if scope.present?
    Post.tagged_with(tag, on: :tags)
  end
end