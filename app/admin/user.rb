ActiveAdmin.register User do
  permit_params :name, :email

  # use the normal "new user" path instead
  actions :all, except: :new

  controller do
    def csv_filename
      'Users.csv'
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :institution
    column :access_type
    column :address
  end

  filter :name
  filter :email
  filter :access_type
  filter :institution

  csv force_quotes: true, col_sep: ',' do
    column :id
    column :name
    column :gender
    column :email
    column :access_type
    column :phone
    column :created_at
    column :updated_at
  end
end
