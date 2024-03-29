# frozen_string_literal: true

module ApplicationHelper
  def application_timezone
    ENV.try(:fetch, 'TIMEZONE', 'UTC')
  end

  # def localized_creation_time(article)
  #   article.created_at.in_time_zone(application_timezone)
  # end

  def modal
    {
      title: 'Sign out',
      content: "<p> #{current_user.name}, you are about to sign out of your profile.</p> Are you sure?".html_safe,
      confirm: 'Sign me out',
    }
  end

  def institution
    current_user.institution
  end

  def classes
    IClass.for(institution)
  end

  def flash_class(lvl)
    case lvl
    when "notice"
      "success"
    when "alert"
      "error"
    else
      raise "This should be unreachable."
    end
  end

  def select_options(collection)
    collection.map {|x| [x.name, x.id]}
  end
end
