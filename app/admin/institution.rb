ActiveAdmin.register Institution do
  permit_params :name, :location

  controller do
    def csv_filename
      'Institutions.csv'
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :location

    column :users_count do |i|
      i.users.count
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :location
      f.input :code, input_html: { value: SecureRandom.alphanumeric(20) }
    end
    f.actions
  end

  filter :name
  filter :location

  csv force_quotes: true,  col_sep: ',' do
    column :id
    column :name
    column :location

    column :users_count do |i|
      i.users.count
    end
  end
end
