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
end
