module ReportsHelper
  def report_request_scopes
    Report.creation_scopes.except(:unknown)
  end
end
