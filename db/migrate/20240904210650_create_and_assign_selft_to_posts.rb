class CreateAndAssignSelftToPosts < ActiveRecord::Migration[7.2]
  def up
    camino_zero = Shelf.create!(name: "Camino Zero")
    camino_uno  = Shelf.create!(name: "Camino Uno")

    Post.find_in_batches do |group|
      group.each do |single_post|
        puts "*" * 50
        puts "Starting to process:"
        puts single_post.slug
        puts "*" * 50
        if single_post.tag_list.include?(Post::CAMINO_ZERO)
          single_post.shelf_id = camino_zero.id
          single_post.tag_list = camino_zero.slug
        else
          single_post.shelf_id = camino_uno.id
          single_post.tag_list = camino_uno.slug
        end
        single_post.save!
        puts single_post.slug
        puts " saved!"
      end

    end
  end

  def down
    puts "Starting to process:"
    Shelf.destroy_all
    puts "all Shelf destroyed!"
    Post.update_all(shelf_id: nil)
    puts "All post to shelf_id: nil"
  end
end
