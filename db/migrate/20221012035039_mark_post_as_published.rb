class MarkPostAsPublished < ActiveRecord::Migration[5.2]
  def change
    Post.update_all(published: true)
  end
end
