require ("util")

local hit_effects = require ("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

data:extend({
  {
    type = "simple-entity-with-owner",
		render_layer = "lower-object",
    name = "wooden-billboard",
    icon = "__simple-billboard__/graphics/icons/wooden-billboard.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "wooden-billboard"},
    max_health = 100,
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
          height = 32,
          shift = util.by_pixel(0.5, -2),
          hr_version =
          {
            filename = "__simple-billboard__/graphics/entity/wooden-billboard/hr-wooden-billboard.png",
            priority = "extra-high",
            width = 64,
            height = 64,
            shift = util.by_pixel(0.5, -2),
            scale = 0.5
          }
        },
        {
          filename = "__simple-billboard__/graphics/entity/wooden-billboard/billboard-billboard-shadow.png",
          priority = "extra-high",
          width = 32,
          height = 32,
          draw_as_shadow = true,
          shift = util.by_pixel(1, -2),
          hr_version =
          {
            filename = "__simple-billboard__/graphics/entity/wooden-billboard/hr-wooden-billboard-shadow.png",
            priority = "extra-high",
            width = 64,
            height = 64,
            draw_as_shadow = true,
            shift = util.by_pixel(1, -2),
            scale = 0.5
          }
        }
      }
    },
  },
  {
    type = "simple-entity-with-owner",
		render_layer = "lower-object",
    name = "wooden-billboard-1x2",
    icon = "__simple-billboard__/graphics/icons/wooden-billboard-1x2.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "wooden-billboard-1x2"},
    max_health = 100,
    dying_explosion = "wooden-chest-explosion",
    collision_box = {{-0.85, -0.35}, {0.85, 0.35}},
    selection_box = {{-1, -0.5}, {1, 0.5}},
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
          filename = "__simple-billboard__/graphics/entity/wooden-billboard/wooden-billboard-1x2.png",
          priority = "extra-high",
          width = 62,
          height = 31,
          shift = util.by_pixel(0.5, -2),
          hr_version =
          {
            filename = "__simple-billboard__/graphics/entity/wooden-billboard/hr-wooden-billboard-1x2.png",
            priority = "extra-high",
            width = 124,
            height = 62,
            shift = util.by_pixel(0.5, -2),
            scale = 0.5
          }
        },
        {
          filename = "__simple-billboard__/graphics/entity/wooden-billboard/billboard-billboard-shadow-1x2.png",
          priority = "extra-high",
          width = 62,
          height = 31,
          draw_as_shadow = true,
          shift = util.by_pixel(1, -2),
          hr_version =
          {
            filename = "__simple-billboard__/graphics/entity/wooden-billboard/hr-wooden-billboard-shadow-1x2.png",
            priority = "extra-high",
            width = 124,
            height = 62,
            shift = util.by_pixel(1, -2),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
  },
  {
    type = "simple-entity-with-owner",
		render_layer = "lower-object",
    name = "wooden-billboard-1x4",
    icon = "__simple-billboard__/graphics/icons/wooden-billboard-1x4.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "wooden-billboard-1x4"},
    max_health = 100,
    dying_explosion = "wooden-chest-explosion",
    collision_box = {{-1.85, -0.35}, {1.85, 0.35}},
    selection_box = {{-2, -0.5}, {2, 0.5}},
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
          filename = "__simple-billboard__/graphics/entity/wooden-billboard/wooden-billboard-1x4.png",
          priority = "extra-high",
          width = 124,
          height = 31,
          shift = util.by_pixel(0.5, -2),
          hr_version =
          {
            filename = "__simple-billboard__/graphics/entity/wooden-billboard/hr-wooden-billboard-1x4.png",
            priority = "extra-high",
            width = 248,
            height = 62,
            shift = util.by_pixel(0.5, -2),
            scale = 0.5
          }
        },
        {
          filename = "__simple-billboard__/graphics/entity/wooden-billboard/billboard-billboard-shadow-1x4.png",
          priority = "extra-high",
          width = 124,
          height = 31,
          draw_as_shadow = true,
          shift = util.by_pixel(1, -2),
          hr_version =
          {
            filename = "__simple-billboard__/graphics/entity/wooden-billboard/hr-wooden-billboard-shadow-1x4.png",
            priority = "extra-high",
            width = 248,
            height = 62,
            shift = util.by_pixel(1, -2),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
  },
  {
    type = "simple-entity-with-owner",
		render_layer = "lower-object",
    name = "wooden-billboard-2x2",
    icon = "__simple-billboard__/graphics/icons/wooden-billboard-2x2.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "wooden-billboard-2x2"},
    max_health = 200,
    dying_explosion = "wooden-chest-explosion",
    collision_box = {{-0.85, -0.85}, {0.85, 0.85}},
    selection_box = {{-1, -1}, {1, 1}},
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
          filename = "__simple-billboard__/graphics/entity/wooden-billboard/wooden-billboard-2x2.png",
          priority = "extra-high",
          width = 62,
          height = 59,
          shift = util.by_pixel(0.5, -2),
          hr_version =
          {
            filename = "__simple-billboard__/graphics/entity/wooden-billboard/hr-wooden-billboard-2x2.png",
            priority = "extra-high",
            width = 124,
            height = 118,
            shift = util.by_pixel(0.5, -2),
            scale = 0.5
          }
        },
        {
          filename = "__simple-billboard__/graphics/entity/wooden-billboard/billboard-billboard-shadow-2x2.png",
          priority = "extra-high",
          width = 62,
          height = 59,
          shift = util.by_pixel(1, -2),
          draw_as_shadow = true,
          hr_version =
          {
            filename = "__simple-billboard__/graphics/entity/wooden-billboard/hr-wooden-billboard-shadow-2x2.png",
            priority = "extra-high",
            width = 124,
            height = 118,
            shift = util.by_pixel(1, -2),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
  },
  {
    type = "simple-entity-with-owner",
		render_layer = "lower-object",
    name = "wooden-billboard-2x4",
    icon = "__simple-billboard__/graphics/icons/wooden-billboard-2x4.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "wooden-billboard-2x4"},
    max_health = 200,
    dying_explosion = "wooden-chest-explosion",
    collision_box = {{-1.85, -0.85}, {1.85, 0.85}},
    selection_box = {{-2, -1}, {2, 1}},
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
          filename = "__simple-billboard__/graphics/entity/wooden-billboard/wooden-billboard-2x4.png",
          priority = "extra-high",
          width = 130,
          height = 62,
          shift = util.by_pixel(0.5, -2),
          hr_version =
          {
            filename = "__simple-billboard__/graphics/entity/wooden-billboard/hr-wooden-billboard-2x4.png",
            priority = "extra-high",
            width = 248,
            height = 118,
            shift = util.by_pixel(0.5, -2),
            scale = 0.5
          }
        },
        {
          filename = "__simple-billboard__/graphics/entity/wooden-billboard/billboard-billboard-shadow-2x4.png",
          priority = "extra-high",
          width = 130,
          height = 62,
          draw_as_shadow = true,
          shift = util.by_pixel(1, -2),
          hr_version =
          {
            filename = "__simple-billboard__/graphics/entity/wooden-billboard/hr-wooden-billboard-shadow-2x4.png",
            priority = "extra-high",
            width = 248,
            height = 118,
            shift = util.by_pixel(1, -2),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
  },
  {
    type = "simple-entity-with-owner",
		render_layer = "lower-object",
    name = "wooden-billboard-4x4",
    icon = "__simple-billboard__/graphics/icons/wooden-billboard-4x4.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "wooden-billboard-4x4"},
    max_health = 300,
    dying_explosion = "wooden-chest-explosion",
    collision_box = {{-1.85, -0.85}, {1.85, 0.85}},
    selection_box = {{-2, -2}, {2, 2}},
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
          filename = "__simple-billboard__/graphics/entity/wooden-billboard/wooden-billboard-4x4.png",
          priority = "extra-high",
          width = 124,
          height = 129,
          shift = util.by_pixel(0.5, -2),
          hr_version =
          {
            filename = "__simple-billboard__/graphics/entity/wooden-billboard/hr-wooden-billboard-4x4.png",
            priority = "extra-high",
            width = 248,
            height = 258,
            shift = util.by_pixel(0.5, -2),
            scale = 0.5
          }
        },
        {
          filename = "__simple-billboard__/graphics/entity/wooden-billboard/billboard-billboard-shadow-4x4.png",
          priority = "extra-high",
          width = 124,
          height = 129,
          draw_as_shadow = true,
          shift = util.by_pixel(1, -2),
          hr_version =
          {
            filename = "__simple-billboard__/graphics/entity/wooden-billboard/hr-wooden-billboard-shadow-4x4.png",
            priority = "extra-high",
            width = 248,
            height = 258,
            shift = util.by_pixel(1, -2),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
  },
})