defmodule ThirtyPlantsWeb.AddLiveStyles do
  use LiveViewNative.Stylesheet, :swiftui

  ~SHEET"""
  "search-box" do
    textFieldStyle(.roundedBorder)
  end

  "fg-color-" <> fg_color do
    foregroundStyle(to_ime(fg_color))
  end

  "fg-color:" <> fg_color do
    foregroundStyle(Color(fg_color))
  end

  "px-" <> length do
    padding(.horizontal, to_float(length))
  end

  "py-" <> length do
    padding(.vertical, to_float(length))
  end
  """

  def class(_, _), do: {:unmatched, []}
end
