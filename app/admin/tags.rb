ActiveAdmin.register Tag do

  permit_params do
    permitted = [:name]
    permitted
  end

  index do
    id_column
    column :name
    actions
  end
end