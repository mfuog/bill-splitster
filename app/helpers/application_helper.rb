module ApplicationHelper
  # Helper method that:
  # - sets a hidden field for the _destroy attribute's value to 1 so that the
  #   record gets deleted when the surrounding form is submitted
  # - sets a link that visually hides the form's fields.
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to(name, "#", onclick: "remove_fields(this)")
  end
end

def link_to_add_fields(name, f, association)
  new_object = f.object.class.reflect_on_association(association).klass.new
  fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
    render(association.to_s.singularize + "_fields", :f => builder)
  end
  link_to(name, "#", onclick: "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
end