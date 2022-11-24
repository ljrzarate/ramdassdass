class UpdateFrindlyIdToExistingPosts < ActiveRecord::Migration[5.2]
  def change
    Post.find_each(&:save)
  end
end
