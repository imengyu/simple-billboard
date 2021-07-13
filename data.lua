--data.lua

require("prototypes/item/item")
require("prototypes/entity/entity")
require("prototypes/recipe/recipe")

--Gui styles
local styles = data.raw["gui-style"].default

styles["ugg_content_frame"] = {
  type = "frame_style",
  parent = "inside_shallow_frame_with_padding",
  vertical_spacing = 16,
}

styles["ugg_controls_flow"] = {
  type = "horizontal_flow_style",
  top_margin = 16,
  vertical_align = "center",
}
styles["ugg_controls_flow_spacing"] = {
  type = "horizontal_flow_style",
  top_margin = 16,
  vertical_align = "center",
  horizontal_spacing = 16,
}
styles["ugg_vertical_controls_flow"] = {
  type = "vertical_flow_style",
  top_margin = 16,
  vertical_spacing = 16,
}

styles["ugg_controls_textfield"] = {
  type = "textbox_style",
  width = 250,
  height = 100
}

styles["ugg_scroll_panel"] = {
  type = "scroll_pane_style",
  parent = "scroll_pane_in_shallow_frame",
  top_padding = 16,
  left_padding = 8,
  right_padding = 8,
  bottom_padding = 4
}

styles["notched_slider"].width = 300