ActiveAdmin.register Post do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :content, :title, :summary
  #
  # or
  #
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
    end

    f.actions
  end

end
