ActiveAdmin.register Post do
 filter :title

  controller do
    def find_resource
      begin
        scoped_collection.where(slug: params[:id]).first!
      rescue ActiveRecord::RecordNotFound
        scoped_collection.find(params[:id])
      end
    end
  end

  permit_params do
    permitted = [:content, :title, :summary, :main_image, :published, images: []]
    #permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  member_action :upload, method: [:post] do
    success = resource.images.attach(params[:file_upload])
    result = success ? { link: url_for(resource.images.last) } : {}
    render json: result
  end

  form title: 'Create Post' do |f|
    f.inputs do
      f.input :title
      f.input :summary
      f.input :published
      unless resource.new_record?
        f.input :content, as: :froala_editor, input_html: { data: { options: { imageUploadParam: 'file_upload', imageUploadURL: upload_admin_post_path(resource.id), toolbarButtons: %w[undo redo  | bold italic underline strikeThrough subscript superscript outdent indent clearFormatting insertTable | insertImage insertVideo insertFile | html insertLink] } } }
      end
      f.input :main_image, as: :file
      f.input :tags,
        as: :select,
        multiple: :true,
        collection: ActsAsTaggableOn::Tag.select(:id, :name).all
    end

    f.actions
  end

end
