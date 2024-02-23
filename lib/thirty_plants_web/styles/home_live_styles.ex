defmodule ThirtyPlantsWeb.HomeLiveStyles do
  use LiveViewNative.Stylesheet, :swiftui

  ~SHEET"""
  "px-" <> length do
    padding(.horizontal, to_float(length))
  end

  "py-" <> length do
    padding(.vertical, to_float(length))
  end
  """

  def class(_, _), do: {:unmatched, []}
end
