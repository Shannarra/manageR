ActiveAdmin.register IClass do
  permit_params :name, :year, :description, :institution_id

  controller do
    def csv_filename
      'Classes.csv'
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :year
    column :description
    column :institution do |i|
      i.institution.name
    end

    column :students_count do |i|
      User.where(i_class: i).count
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :year
      f.input :description, input_html: { value: 'Enter description for this class' }
      f.input :institution_id
    end
    f.actions
  end

  filter :name
  filter :location

  csv force_quotes: true,  col_sep: ',' do
    column :id
    column :name
    column :year
    column :description
    column :institution do |i|
      i.institution.name
    end

    column :students_count do |i|
      User.where(i_class: i).count
    end
  end
end
