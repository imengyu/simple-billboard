require ("util")

local hit_effects = require ("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

data:extend({
  {
    type = "container",
    name = "wooden-billboard",
    icon = "__simple-billboard__/graphics/icons/wooden-billboard.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "wooden-billboard"},
    max_health = 100,
    corpse = "wooden-billboard-remnants",
    dying_explosion = "wooden-chest-explosion",
    collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    inventory_size = 0,
    open_sound = { filename = "__base__/sound/wooden-chest-open.ogg", volume = 0.6 },
    close_sound = { filename = "__base__/sound/wooden-chest-close.ogg", volume = 0.6 },
    vehicle_impact_sound = sounds.car_wood_impact(0.5),
    picture =
    {
      layers =
      {
        {
          filename = "__simple-billboard__/graphics/entity/wooden-billboard/wooden-billboard.png",
          priority = "extra-high",
          width = 32,
          height = 36,
          shift = util.by_pixel(0.5, -2),
          hr_version =
          {
            filename = "__simple-billboard__/graphics/entity/wooden-billboard/hr-wooden-billboard.png",
            priority = "extra-high",
            width = 62,
            height = 72,
            shift = util.by_pixel(0.5, -2),
            scale = 0.5
          }
        },
        {
          filename = "__simple-billboard__/graphics/entity/wooden-billboard/billboard-billboard-shadow.png",
          priority = "extra-high",
          width = 52,
          height = 20,
          shift = util.by_pixel(10, 6.5),
          draw_as_shadow = true,
          hr_version =
          {
            filename = "__simple-billboard__/graphics/entity/wooden-billboard/hr-wooden-billboard-shadow.png",
            priority = "extra-high",
            width = 104,
            height = 40,
            shift = util.by_pixel(10, 6.5),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
  },
  {
    type = "corpse",
    name = "wooden-billboard-remnants",
    icon = "__simple-billboard__/graphics/icons/wooden-billboard.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    subgroup = "storage-remnants",
    order = "a-a-a",
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    tile_width = 1,
    tile_height = 1,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation =
    {
      filename = "__simple-billboard__/graphics/entity/wooden-billboard/remnants/wooden-billboard-remnants.png",
      line_length = 1,
      width = 56,
      height = 38,
      frame_count = 1,
      direction_count = 1,
      shift = util.by_pixel(8, -1),
      hr_version =
      {
        filename = "__simple-billboard__/graphics/entity/wooden-billboard/remnants/hr-wooden-billboard-remnants.png",
        line_length = 1,
        width = 110,
        height = 74,
        frame_count = 1,
        direction_count = 1,
        shift = util.by_pixel(7.5, -1),
        scale = 0.5
      }
    }
  },
})