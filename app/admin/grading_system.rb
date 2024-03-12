ActiveAdmin.register GradingSystem do
  permit_params :name,
                :start_grade,
                :end_grade,
                :step,
                :direction,
                :description,
                :possible_grades,
                :institution_id

  controller do
    def csv_filename
      'GradingSystems.csv'
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :start_grade
    column :end_grade
    column :step
    column :direction
    column :description
    column :possible_grades, optional: true

    column :institutions_count do |s|
      Institution.where(id: s.institution_id).count
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :start_grade
      f.input :end_grade
      f.input :step
      f.input :direction
      f.input :description
      f.input :possible_grades
      f.input :institution_id
    end
    f.actions
  end

  filter :name
  filter :direction

  csv force_quotes: true,  col_sep: ',' do
    column :id
    column :name
    column :start_grade
    column :end_grade
    column :step
    column :direction
    column :description
    column :possible_grades

    column :institutions_count do |s|
      Institution.where(id: s.institution_id).count
    end
  end
end
