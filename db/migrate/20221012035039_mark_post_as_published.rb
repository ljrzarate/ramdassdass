class MarkPostAsPublished < ActiveRecord::Migration[7.2]
  def change
    Post.update_all(published: true)
  end
end
