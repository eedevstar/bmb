module ApplicationHelper
  include Pagy::Frontend

  def date_str(datetime)
    datetime.strftime("%B %e, %Y")
  end
end
