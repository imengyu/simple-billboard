
data:extend({{
	name = "billboards",
	type = "item-subgroup",
	group = "logistics",
	order = "z[billboards]"
}})

data:extend({
  {
    type = "item",
    name = "wooden-billboard",
    icon = "__simple-billboard__/graphics/icons/wooden-billboard.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "billboards",
    order = "a[items]-a[wooden-billboard]",
    place_result = "wooden-billboard",
    stack_size= 100
  },
  {
    type = "item",
    name = "wooden-billboard-1x2",
    icon = "__simple-billboard__/graphics/icons/wooden-billboard-1x2.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "billboards",
    order = "a[items]-a[wooden-billboard]",
    place_result = "wooden-billboard-1x2",
    stack_size= 50
  },
  {
    type = "item",
    name = "wooden-billboard-1x4",
    icon = "__simple-billboard__/graphics/icons/wooden-billboard-1x4.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "billboards",
    order = "a[items]-a[wooden-billboard]",
    place_result = "wooden-billboard-1x4",
    stack_size= 50
  },
  {
    type = "item",
    name = "wooden-billboard-2x4",
    icon = "__simple-billboard__/graphics/icons/wooden-billboard-2x4.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "billboards",
    order = "a[items]-a[wooden-billboard]",
    place_result = "wooden-billboard-2x4",
    stack_size= 50
  },
  {
    type = "item",
    name = "wooden-billboard-2x2",
    icon = "__simple-billboard__/graphics/icons/wooden-billboard-2x2.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "billboards",
    order = "a[items]-a[wooden-billboard]",
    place_result = "wooden-billboard-2x2",
    stack_size= 50
  },
  {
    type = "item",
    name = "wooden-billboard-4x4",
    icon = "__simple-billboard__/graphics/icons/wooden-billboard-4x4.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "billboards",
    order = "a[items]-a[wooden-billboard]",
    place_result = "wooden-billboard-4x4",
    stack_size= 50
  },
})