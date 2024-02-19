defmodule ThirtyPlantsWeb.Layouts do
  use ThirtyPlantsWeb, :html
  use LiveViewNative.Layouts

  embed_templates "layouts/*.html"
end
