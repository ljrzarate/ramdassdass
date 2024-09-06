ActiveAdmin.register Post do
  filter :title
  filter :is_box
  filter :parent_box, collection: proc { Post.where(is_box: true) }
  filter :shelf

  controller do
    def find_resource
      begin
        finder = resource_class.is_a?(FriendlyId) ? :slug : :id
        scoped_collection.find_by(finder => params[:id])
      rescue ActiveRecord::RecordNotFound
        scoped_collection.find(params[:id])
      end
    end

    def create
      parent_box = Post.find_by(is_box: true, id: permitted_params[:post][:parent_box_id])
      @post = Post.new(permitted_params[:post])
      resource.tag_list.add(resource.shelf.slug, resource.slug)
      resource.tag_list.add(parent_box.slug) if !resource.is_box? && parent_box.present?
      create!
    end

    def update
      if parse_boolean(permitted_params[:post][:published]) && resource.is_box?
        Post.where(is_box: false, parent_box_id: resource.id).update_all(published: true)
      end
      parent_box = Post.find_by(is_box: true, id: permitted_params[:post][:parent_box_id])
      resource.tag_list.add(resource.shelf.slug, resource.slug)
      resource.tag_list.add(parent_box.slug)  unless  resource.is_box?
      super
    end

    def parse_boolean(value)
      ActiveRecord::Type::Boolean.new.deserialize(value)
    end
  end

  permit_params do
    permitted = [
      :id,
      :shelf_id, :parent_box_id, :is_box,
      :content, :title, :summary, :main_image, :published,
      tag_ids: [], images: []
    ]
    permitted
  end

  member_action :upload, method: [:post] do
    success = resource.images.attach(params[:file_upload])
    result = success ? { link: url_for(resource.images.last) } : {}
    render json: result
  end

  index do
    id_column
    column :title
    column :published
    column :is_box
    column :parent_box_name
    column :shelf_name
    column :tag_list
    column :summary
    actions
  end

  form title: 'Create Post' do |f|
    f.semantic_errors
    f.inputs do
      f.input :title
      f.input :summary
      f.input :published
      f.input :main_image, as: :file
      f.input :shelf,
        as: :select,
        multiple: false,
        collection: Shelf.select(:id, :name).all

      f.input :parent_box,
        as: :select,
        multiple: false,
        collection: Post.select(:id, :title).where(is_box: true)
      f.input :is_box

      f.input :tags,
        as: :select,
        multiple: :true,
        collection: ActsAsTaggableOn::Tag.select(:id, :name).all
      unless resource.new_record?
        f.input :content, as: :froala_editor, input_html: { data: { options: { imageUploadParam: 'file_upload', imageUploadURL: upload_admin_post_path(resource.id), toolbarButtons: %w[undo redo  | bold italic underline strikeThrough subscript superscript outdent indent clearFormatting insertTable | insertImage insertVideo insertFile | html insertLink] } } }
      end
    end

    f.actions
  end

end
