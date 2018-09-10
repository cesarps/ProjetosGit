# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'categoria', 'categorias'
  inflect.irregular "departamento", "departamentos"
  inflect.irregular 'album', 'albuns'
  inflect.irregular 'fotografia','fotografias'
  inflect.irregular 'colecao', 'colecoes'
end


# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
