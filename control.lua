require ("utils")
require ("util")

local name_wooden_billboard_gui_root = "billboard-gui"
local name_wooden_billboard = "wooden-billboard"

--Options
-----------------------------------------------------------------

max_chars = 128
text_colors = {
  white = {r=1,g=1,b=1},
  grey = {r=0.4,g=0.4,b=0.4},
  black = {r=0,g=0,b=0},
  red = {r=0.8,g=0.3,b=0},
  yellow = {r=0.8,g=0.7,b=0.3},
  green = {r=0.3,g=0.7,b=0.3},
  blue = {r=0.3,g=0.4,b=0.8},
  pink = {r=0.8,g=0.3,b=0.6},
  cyan = {r=0.3,g=0.8,b=0.7},
}

--Data storage
-----------------------------------------------------------------

local function get_storage_billboard_data(entity) 
  if global.billboard_data == nil then global.billboard_data = {} end
  return global.billboard_data[entity.unit_number]
end
local function storage_billboard_data(entity, newData) 
  if global.billboard_data == nil then global.billboard_data = {} end
  global.billboard_data[entity.unit_number] = newData
end
local function remove_billboard_data(entity) 
  global.billboard_data[entity.unit_number] = nil
end
local function create_billboard_default_data(entity)
  local data = {
    text = "Add\nText",
    color = {r=1,g=1,b=1},
    scale = 0.7,
    offset = { x=-0.4, y=-0.55 },
    align = 'left',
    orientation = 0,
    line_height = 10,

    sprite_orientation = 0,
    sprite_offset = { x=-0, y=-0.2 },
    sprite_scale = 0.6,
    signal_str = '',
  }
  storage_billboard_data(entity, data)
  return data
end
--[[
local function align_to_number(align)
  if align == 'left' then
    return 0
  elseif align == 'center' then
    return 1
  elseif align == 'right' then
    return 2
  end
  return 0
end
]]--

--Text renderer
-----------------------------------------------------------------

local text_render_storage = {}
local singal_render_storage = {}

local function destroy_text_render(entity) 
  local oldRender = text_render_storage[entity.unit_number]
  if oldRender ~= nil then
    if type(oldRender) == "table" then
      for k, v in pairs(oldRender) do      
        if rendering.is_valid(v) then
          rendering.destroy(v)
        end  
      end  
    elseif rendering.is_valid(oldRender) then
      rendering.destroy(oldRender)
    end
  end
end
local function create_text_render(entity, data) 
  if data == nil then return  end
  if text_render_storage[entity.unit_number] ~= nil then
    destroy_text_render(entity)
  end

  ---Fix wrap text
  if string.find(data.text, '\n') ~= nil then
    local arr = Split(data.text, '\n')
    local currentOffset = 0
    local render_storage = {}
    for k, v in pairs(arr) do      
      table.insert( render_storage, 0, rendering.draw_text{
        text = v,
        surface = entity.surface,
        target = entity,
        target_offset = { data.offset.x, data.offset.y + currentOffset },
        color = data.color,
        scale = data.scale,
        align = data.align,
        orientation = data.orientation,
      })
      currentOffset = currentOffset + data.line_height / 30.0 * data.scale
    end  
    text_render_storage[entity.unit_number] = render_storage
  else
    --Normal text
    text_render_storage[entity.unit_number] = rendering.draw_text{
      text = data.text,
      surface = entity.surface,
      target = entity,
      target_offset = { data.offset.x, data.offset.y },
      color = data.color,
      scale = data.scale,
      align = data.align,
      orientation = data.orientation,
    }
  end
end
local function recreate_text_render(entity, data) 
  destroy_text_render(entity)
  create_text_render(entity, data)
end
local function destroy_singal_render(entity) 
  local oldRender = singal_render_storage[entity.unit_number]
  if oldRender ~= nil then
    rendering.destroy(oldRender)
  end
end
local function create_singal_render(entity, data) 
  if data == nil then return  end
  if singal_render_storage[entity.unit_number] ~= nil then
    destroy_singal_render(entity)
  end

  --Render a singal
  if data.signal_str ~= '' then
    singal_render_storage[entity.unit_number] = rendering.draw_sprite{
      sprite = data.signal_str, 
      surface = entity.surface,
      target = entity,
      target_offset = { data.sprite_offset.x, data.sprite_offset.y },
      x_scale = data.sprite_scale,
      y_scale = data.sprite_scale,
      tint = data.color,
      orientation = data.sprite_orientation,
    }
  end
end
local function recreate_singal_render(entity, data) 
  destroy_singal_render(entity)
  create_singal_render(entity, data)
end

--Update
-----------------------------------------------------------------

local function update_billboard_text_display(entity)
  local data = get_storage_billboard_data(entity)
  if entity then
    recreate_text_render(entity, data)
  end
end
local function update_billboard_singal_display(entity)
  local data = get_storage_billboard_data(entity)
  if entity then
    recreate_singal_render(entity, data)
  end
end
local function update_billboard_color(entity, color)
  local data = get_storage_billboard_data(entity)
  if data then
    data.color = text_colors[color]
    recreate_text_render(entity, data)
    recreate_singal_render(entity, data)
  end
end

--Gui
-----------------------------------------------------------------

---Gui creation
local function open_gui (player, entity)
  if not (entity and entity.valid) then return end

  local gui = player.gui.screen
  player.opened = nil
  global.selected[player.index] = entity --Not used here, but used in gui_click
  if gui[name_wooden_billboard_gui_root] then
    gui[name_wooden_billboard_gui_root].destroy()
  end

  --Data
  local data = get_storage_billboard_data(entity)
  if(data == nil) then
    data = create_billboard_default_data(entity)
  end
  
  --Build gui
  local container = gui.add{ type = "frame", name = name_wooden_billboard_gui_root, direction="vertical" }
  container.style.size = {480, 480}
  container.auto_center = true

  player.opened = container
  --Gui may be invalidated by previous line.
  if not (container and container.valid) then return end

  local title_flow = container.add{ type="flow", name="unit_number", direction="horizontal"}
  -- NOTE: [name_rocket_landing_pad_gui_root].unit_number.child_names()[1] gets unit number
  local title = title_flow.add{ type="label", name=entity.unit_number, caption={"entity-name." .. entity.name}, style="heading_1_label"}
  title.ignored_by_interaction = true
  title_flow.drag_target=container

  -- Trying to make the fancy "Drag me" vertical bars...
  local drag_handle = title_flow.add{type = "empty-widget", style = "draggable_space_header", direction="horizontal"}
  drag_handle.drag_target = container
  drag_handle.style.minimal_width = 20
  drag_handle.style.horizontally_stretchable = true
  drag_handle.style.vertically_stretchable = true

  title_flow.add{type="sprite-button", name="billboard-gui-close", sprite = "utility/close_white", style="tool_button"}
  
  --Add frames
  local content_frame = container.add{type="scroll-pane", horizontal_scroll_policy="auto", style="ugg_scroll_panel", direction="vertical"}
  local controls_flow_text = content_frame.add{type="flow", name="controls_flow_text", direction="horizontal", style="ugg_controls_flow_spacing"}
  local controls_flow_color = content_frame.add{type="flow", name="controls_flow_color", direction="horizontal", style="ugg_controls_flow"}
  local controls_flow_color2 = content_frame.add{type="flow", name="controls_flow_color2", direction="horizontal", style="ugg_controls_flow"}
  local controls_flow_scale = content_frame.add{type="flow", name="controls_flow_scale", direction="horizontal", style="ugg_controls_flow_spacing"}
  local controls_flow_xoff = content_frame.add{type="flow", name="controls_flow_xoff", direction="horizontal", style="ugg_controls_flow"}
  local controls_flow_yoff = content_frame.add{type="flow", name="controls_flow_yoff", direction="horizontal", style="ugg_controls_flow"}
  local controls_flow_orientation = content_frame.add{type="flow", name="controls_flow_orientation", direction="horizontal", style="ugg_controls_flow"}
  --local controls_flow_align = content_frame.add{type="flow", name="controls_flow_align", direction="horizontal", style="ugg_controls_flow"}
  local controls_flow_line_height = content_frame.add{type="flow", name="controls_flow_line_height", direction="horizontal", style="ugg_controls_flow"}

  local controls_flow_sprite_scale = content_frame.add{type="flow", name="controls_flow_sprite_scale", direction="horizontal", style="ugg_controls_flow_spacing"}
  local controls_flow_sprite_xoff = content_frame.add{type="flow", name="controls_flow_sprite_xoff", direction="horizontal", style="ugg_controls_flow"}
  local controls_flow_sprite_yoff = content_frame.add{type="flow", name="controls_flow_sprite_yoff", direction="horizontal", style="ugg_controls_flow"}
  local controls_flow_sprite_orientation = content_frame.add{type="flow", name="controls_flow_sprite_orientation", direction="horizontal", style="ugg_controls_flow"}

  global.players[player.index].input_text = controls_flow_text.add{type="text-box", name="billboard-gui-textfield", text=data.text, style="ugg_controls_textfield"}
  local controls_flow_text_buttons = controls_flow_text.add{type="flow", name="controls_flow_text_buttons", direction="vertical"}
  controls_flow_text_buttons.add{type="button", name="billboard-gui-update-text", caption={"billboard.gui.update-text"}}
  controls_flow_text_buttons.add{type="button", name="billboard-gui-clear-text", caption={"billboard.gui.clear-text"}}
  controls_flow_text.add{type="choose-elem-button", elem_type="signal", name="billboard-insert-signal", elem_value=data.signal_str, tooltip={"billboard.gui.draw-a-singal"}}

  controls_flow_color.add{type="label", name="billboard-gui-color-label", caption={"billboard.gui.color-text"}, style="label"}
  controls_flow_color.add{type="sprite-button", name="billboard-gui-color-white", sprite="virtual-signal/signal-white", tooltip={"signal-white"}}
  controls_flow_color.add{type="sprite-button", name="billboard-gui-color-grey", sprite="virtual-signal/signal-grey", tooltip={"signal-grey"}}
  controls_flow_color.add{type="sprite-button", name="billboard-gui-color-black", sprite="virtual-signal/signal-black", tooltip={"signal-black"}}
  controls_flow_color.add{type="sprite-button", name="billboard-gui-color-red", sprite="virtual-signal/signal-red", tooltip={"signal-red"}}
  controls_flow_color.add{type="sprite-button", name="billboard-gui-color-yellow", sprite="virtual-signal/signal-yellow", tooltip={"signal-yellow"}}
  controls_flow_color2.add{type="label", name="billboard-gui-color-label", caption={"billboard.gui.color-space-text"}, style="label"}
  controls_flow_color2.add{type="sprite-button", name="billboard-gui-color-green", sprite="virtual-signal/signal-green", tooltip={"signal-green"}}
  controls_flow_color2.add{type="sprite-button", name="billboard-gui-color-blue", sprite="virtual-signal/signal-blue", tooltip={"signal-blue"}}
  controls_flow_color2.add{type="sprite-button", name="billboard-gui-color-cyan", sprite="virtual-signal/signal-cyan", tooltip={"signal-cyan"}}
  controls_flow_color2.add{type="sprite-button", name="billboard-gui-color-pink", sprite="virtual-signal/signal-pink", tooltip={"signal-pink"}}

  controls_flow_scale.add{type="label", name="billboard-gui-scale-label", caption={"billboard.gui.scale-text"}, style="label"}
  controls_flow_scale.add{type="slider", name="billboard-gui-scale-slider", value=data.scale * 100, minimum_value=30, maximum_value=300, value_step=10, style="notched_slider"}

  controls_flow_xoff.add{type="label", name="billboard-gui-xoff-label", caption={"billboard.gui.xoff-text"}, style="label"}
  controls_flow_xoff.add{type="slider", name="billboard-gui-xoff-slider", value=data.offset.x * 100 + 50, minimum_value=0, maximum_value=100, value_step=5, style="notched_slider"}

  controls_flow_yoff.add{type="label", name="billboard-gui-yoff-label", caption={"billboard.gui.yoff-text"}, style="label"}
  controls_flow_yoff.add{type="slider", name="billboard-gui-yoff-slider", value=data.offset.y * 100 + 100, minimum_value=0, maximum_value=100, value_step=5, style="notched_slider"}

  --controls_flow_align.add{type="label", name="billboard-gui-align-label", caption={"billboard.gui.align-text"}, style="label"}
  --controls_flow_align.add{type="slider", name="billboard-gui-align-slider", value=align_to_number(data.align), minimum_value=0, maximum_value=2, style="notched_slider"}

  controls_flow_orientation.add{type="label", name="billboard-gui-orientation-label", caption={"billboard.gui.orientation-text"}, style="label"}
  controls_flow_orientation.add{type="slider", name="billboard-gui-orientation-slider", value=data.orientation * 100, minimum_value=0, maximum_value=100, value_step=10, style="notched_slider"}
  
  controls_flow_line_height.add{type="label", name="billboard-gui-line-height-label", caption={"billboard.gui.line-height-text"}, style="label"}
  controls_flow_line_height.add{type="slider", name="billboard-gui-line-height-slider", value=data.line_height, minimum_value=8, maximum_value=60, value_step=1, style="notched_slider"}

  controls_flow_sprite_scale.add{type="label", name="billboard-gui-sprite-scale-label", caption={"billboard.gui.sprite-scale-text"}, style="label"}
  controls_flow_sprite_scale.add{type="slider", name="billboard-gui-sprite-scale-slider", value=data.sprite_scale * 100, minimum_value=30, maximum_value=300, value_step=10, style="notched_slider"}

  controls_flow_sprite_xoff.add{type="label", name="billboard-gui-sprite-xoff-label", caption={"billboard.gui.sprite-xoff-text"}, style="label"}
  controls_flow_sprite_xoff.add{type="slider", name="billboard-gui-sprite-xoff-slider", value=data.sprite_offset.x * 100 + 50, minimum_value=0, maximum_value=100, value_step=5, style="notched_slider"}

  controls_flow_sprite_yoff.add{type="label", name="billboard-gui-sprite-yoff-label", caption={"billboard.gui.sprite-yoff-text"}, style="label"}
  controls_flow_sprite_yoff.add{type="slider", name="billboard-gui-sprite-yoff-slider", value=data.sprite_offset.y * 100 + 100, minimum_value=0, maximum_value=100, value_step=5, style="notched_slider"}

  controls_flow_sprite_orientation.add{type="label", name="billboard-gui-sprite-orientation-label", caption={"billboard.gui.sprite-orientation-text"}, style="label"}
  controls_flow_sprite_orientation.add{type="slider", name="billboard-gui-sprite-orientation-slider", value=data.sprite_orientation * 100, minimum_value=0, maximum_value=100, value_step=10, style="notched_slider"}
  

  container.force_auto_center()
end
--Gui textfield handle
local function on_gui_text_changed(event)
  local event_name = event.element.name

  if event_name == "billboard-gui-textfield" then
    local entity = global.selected[event.player_index]

    if entity then
      if #event.element.text > max_chars then
        event.element.text = string.sub(event.element.text, 1, max_chars)
        game.print("SimpleBillboard: Text are limited to "..max_chars.." in length.")
      end

      local data = get_storage_billboard_data(entity)
      if(data == nil) then
        data = create_billboard_default_data(entity)
      end
      
      data.text = event.element.text
      storage_billboard_data(entity, data)
    end
  end
end
local function on_gui_opened(event)
  if event.entity and event.entity.valid then
      if event.entity.name == name_wooden_billboard then
        global.players[event.player_index] = {
          input_text = nil
        }
        open_gui(game.players[event.player_index], event.entity)
      end
  end
end
local function on_close_gui(event)
  if (event.element and event.element.valid) and (event.element.name == name_wooden_billboard_gui_root) then
    event.element.destroy()
    global.players[event.player_index] = nil
    update_billboard_text_display(global.selected[event.player_index])
  end
end
local function on_gui_click(event)
  if not (event.element and event.element.valid) then return end
  local element = event.element
  if element.name == "billboard-gui-close" then
    element.parent.parent.destroy()
  elseif element.name == "billboard-gui-clear-text" then
    global.players[event.player_index].input_text.text = ''
    local entity = global.selected[event.player_index]
    if entity then
      local data = get_storage_billboard_data(entity)
      if(data ~= nil) then
        data.text = ''
        data.signal_str = ''
        storage_billboard_data(entity, data)
        update_billboard_text_display(entity)
        update_billboard_singal_display(entity)
      end
    end
  elseif element.name == "billboard-gui-update-text" then
    update_billboard_text_display(global.selected[event.player_index])
  elseif string.find(element.name, "billboard--gui--color") ~= nil then
    update_billboard_color(global.selected[event.player_index], string.sub(element.name, 21))
  end
end
local function on_gui_value_changed(event)
  if string.find(event.element.name, "billboard--gui") ~= nil then
    local entity = global.selected[event.player_index]
    if entity then
      local update = ''
      local data = get_storage_billboard_data(entity)
      if(data == nil) then
        data = create_billboard_default_data(entity)
      end
      if event.element.name == "billboard-gui-scale-slider" then
        data.scale = event.element.slider_value / 100.0
        update = 'text'
      elseif event.element.name == "billboard-gui-xoff-slider" then
        data.offset.x = event.element.slider_value / 100.0 - 0.5
        update = 'text'
      elseif event.element.name == "billboard-gui-yoff-slider" then
        data.offset.y = event.element.slider_value / 100.0 - 1.0
        update = 'text'
      elseif event.element.name == "billboard-gui-orientation-slider" then
        data.orientation = event.element.slider_value / 100.0
        update = 'text'
      elseif event.element.name == "billboard-gui-line-height-slider" then
        data.line_height = event.element.slider_value
        update = 'text'
      elseif event.element.name == "billboard-gui-align-slider" then
        if event.element.slider_value == 0 then
          data.align = 'left'
        elseif event.element.slider_value == 1 then
          data.align = 'center'
        elseif event.element.slider_value == 2 then
          data.align = 'right'
        end
        update = 'text'
      elseif event.element.name == "billboard-gui-sprite-scale-slider" then
        data.sprite_scale = event.element.slider_value / 100.0
        update = 'singal'
      elseif event.element.name == "billboard-gui-sprite-xoff-slider" then
        data.sprite_offset.x = event.element.slider_value / 100.0 - 0.5
        update = 'singal'
      elseif event.element.name == "billboard-gui-sprite-yoff-slider" then
        data.sprite_offset.y = event.element.slider_value / 100.0 - 1.0
        update = 'singal'
      elseif event.element.name == "billboard-gui-sprite-orientation-slider" then
        data.sprite_orientation = event.element.slider_value / 100.0
        update = 'singal'
      end

      storage_billboard_data(entity, data)
      if update == 'text' then
        update_billboard_text_display(entity)
      elseif  update == 'singal' then
        update_billboard_singal_display(entity)
      end
    end
  end
end
local function on_gui_elem_changed(event)
  if event.element.name == 'billboard-insert-signal' then
    local entity = global.selected[event.player_index]
    local signal = event.element.elem_value
    if entity and signal then
      local data = get_storage_billboard_data(entity)
      if(data == nil) then
        data = create_billboard_default_data(entity)
      end
      if signal.type == 'virtual' then
        data.signal_str = 'virtual-signal.' .. signal.name
      elseif signal.type == 'fluid' then
        data.signal_str = 'fluid.' .. signal.name
      else
        data.signal_str = 'item.' .. signal.name
      end

      storage_billboard_data(entity, data)
      recreate_singal_render(entity, data)
    end
  end
end

script.on_event(defines.events.on_gui_elem_changed, on_gui_elem_changed)
script.on_event(defines.events.on_gui_value_changed, on_gui_value_changed)
script.on_event(defines.events.on_gui_text_changed,on_gui_text_changed)
script.on_event(defines.events.on_gui_opened, on_gui_opened)
script.on_event(defines.events.on_gui_closed, on_close_gui)
script.on_event(defines.events.on_gui_click, on_gui_click)
script.on_event(defines.events.on_gui_confirmed, on_gui_click)

-----------------------------------------------------------------

function on_copy_paste_settings(event)
  local player_index = event.player_index
  if player_index and game.players[player_index] and game.players[player_index].connected 
  and event.source and event.source.valid and event.destination and event.destination.valid then
    if not (event.source.name == name_wooden_billboard) then return end
    if not (event.destination.name == name_wooden_billboard) then return end
    local player = game.players[player_index]
    local source_data = util.table.deepcopy(get_storage_billboard_data(event.source))
    if source_data then
      storage_billboard_data(event.destination, source_data)
      recreate_text_render(event.destination, source_data)
      recreate_singal_render(event.destination, source_data)
    end
  end
end

function on_player_setup_blueprint(event)
  local player_index = event.player_index
  if player_index and game.players[player_index] and game.players[player_index].connected  then
    local player = game.players[player_index]

    -- Get blueprint
    local bp = player.blueprint_to_setup
    if not bp or not bp.valid_for_read then
      bp = player.cursor_stack
    end

    -- Get blueprint entities and mapping
    local entities = bp.get_blueprint_entities()
    if not entities then return end
    local mapping = event.mapping.get()

    -- Find any planetary teleporters in this blueprint
    for i, bp_entity in ipairs(entities) do
      if bp_entity.name == name_wooden_billboard then
        local entity = mapping[i]
        if entity and entity.valid then
          local data = get_storage_billboard_data(entity)
          if data then
            bp.set_blueprint_entity_tag(i, "billboard_user_text_data", Serialize(data))
          end
        end
      end
    end
  end
end

script.on_event(defines.events.on_entity_settings_pasted, on_copy_paste_settings)
script.on_event(defines.events.on_player_setup_blueprint, on_player_setup_blueprint)

-----------------------------------------------------------------

--On destruction
-----------------------------------------------------------------

local function on_destruction(event)
  local entity = event.entity
  if entity.name == game_wooden_billboard then
    local data = get_storage_billboard_data(entity)
    if data then remove_billboard_data(entity) end --delete billboard data
  end
end

script.on_event(defines.events.on_entity_died, on_destruction)
script.on_event(defines.events.on_robot_pre_mined, on_destruction)
script.on_event(defines.events.on_pre_player_mined_item, on_destruction)

--On Built
-----------------------------------------------------------------

local function on_entity_built(event)
  local entity
  if event.entity and event.entity.valid then
    entity = event.entity
  end
  if event.created_entity and event.created_entity.valid then
    entity = event.created_entity
  end
  if entity.name == name_wooden_billboard then
    local billboard_user_text_data = event.tags and event.tags.billboard_user_text_data or nil
    
    local data = billboard_user_text_data and Unserialize(billboard_user_text_data)
    if data == nil then
      data = create_billboard_default_data(entity)
    else
      storage_billboard_data(entity, data)
    end
    create_text_render(entity, data)
    create_singal_render(entity, data)
  end
end

script.on_event(defines.events.on_built_entity, on_entity_built)
script.on_event(defines.events.on_robot_built_entity, on_entity_built)
script.on_event(defines.events.script_raised_built, on_entity_built)
script.on_event(defines.events.script_raised_revive, on_entity_built)

--Configuration
-----------------------------------------------------------------

script.on_configuration_changed(function ()

end)

--Called once, the first time the mod is loaded on a game (new or existing game)
-----------------------------------------------------------------

script.on_init(function ()
  global.players = {}
  global.selected = {} --Player_index -> entity reference
  global.billboard_data = {} -- create billboard_data in global
end)
