class UpdateFrindlyIdToExistingPosts < ActiveRecord::Migration[7.2]
  def change
    Post.find_each(&:save)
  end
end
