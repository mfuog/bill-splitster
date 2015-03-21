module ApplicationHelper
  # Helper method that:
  # - sets a hidden field for the _destroy attribute's value to 1 so that the
  #   record gets deleted when the surrounding form is submitted
  # - sets a link that visually hides the form's fields.
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to(name, "#", onclick: "remove_fields(this)")
  end
end
