--- STEAMODDED HEADER
--- MOD_NAME: Gamepad Prompts
--- MOD_ID: GamepadPrompts
--- MOD_AUTHOR: [AL2009man]
--- MOD_DESCRIPTION: This is a simple mod that replaces Bake-in Xbox prompts with various Controller Icons.
--- BADGE_COLOUR: 234C9B
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]
--- VERSION: 1.1.0

----------------------------------------------
------------MOD CODE -------------------------

sendDebugMessage("Launching Gamepad Prompts Mod!")

-- Initialize GamepadPrompts as the current mod
GamepadPrompts = SMODS.current_mod

-- Default configuration
GamepadPrompts.config = GamepadPrompts.config or {
    controller_type = "Xbox",
    options = {"Xbox", "DualSense", "DualShock4", "NintendoSwitch", "SteamDeck"}
}

-- Map our controller names to Balatro's internal names
local controller_mapping = {
    Xbox = "Xbox",
    DualSense = "Playstation", 
    DualShock4 = "Playstation",
    NintendoSwitch = "Nintendo",
    SteamDeck = "Xbox"
}

-- Controller to texture mapping for custom atlases
local controller_textures = {
    Xbox = "gamepad_ui_xbox",
    DualSense = "gamepad_ui_dualsense", 
    DualShock4 = "gamepad_ui_dualshock4",
    NintendoSwitch = "gamepad_ui_nintendoswitch",
    SteamDeck = "gamepad_ui_steamdeck"
}

-- Store loaded atlases
local loaded_atlases = {}

-- Function to load controller texture
function load_controller_texture(controller_type)
    local texture_key = controller_textures[controller_type]
    if not texture_key then
        return
    end
    
    -- Check if atlas already exists
    if loaded_atlases[texture_key] then
        return loaded_atlases[texture_key]
    end
    
    -- Create texture path
    local texture_path = texture_key .. ".png"
    
    -- Create new atlas for this controller
    local atlas = SMODS.Atlas{
        key = texture_key,
        path = texture_path,
        px = 32,
        py = 32,
    }
    
    -- Store reference to avoid recreating
    loaded_atlases[texture_key] = atlas
    
    return atlas
end

-- Function to update controller graphics
function update_controller_graphics(controller_type)
    -- Update Balatro's internal controller type for prompt behavior
    local balatro_controller = controller_mapping[controller_type]
    if balatro_controller then
        G.CONTROLLER.GAMEPAD_CONSOLE = balatro_controller
    end
    
    -- Load the specific texture for this controller variant
    load_controller_texture(controller_type)
end

-- Function to get current controller atlas key
function get_current_controller_atlas()
    local texture_key = controller_textures[GamepadPrompts.config.controller_type]
    if texture_key and loaded_atlases[texture_key] then
        return loaded_atlases[texture_key].key
    end
    return "gamepad_ui"  -- fallback to default
end

-- Override Sprite.new to intercept gamepad_ui atlas usage
local original_sprite_new = Sprite.new
function Sprite.new(atlas, pos_x, pos_y, w, h)
    -- If the sprite is using gamepad_ui, redirect to current controller atlas
    if atlas == "gamepad_ui" then
        local current_atlas = get_current_controller_atlas()
        if current_atlas ~= "gamepad_ui" then
            atlas = current_atlas
        end
    end
    return original_sprite_new(atlas, pos_x, pos_y, w, h)
end

-- Override G.ASSET_ATLAS access to redirect gamepad_ui to current controller
local original_asset_atlas = G.ASSET_ATLAS
if original_asset_atlas then
    local gamepad_atlas_proxy = {}
    setmetatable(gamepad_atlas_proxy, {
        __index = function(table, key)
            if key == "gamepad_ui" then
                local current_atlas_key = get_current_controller_atlas()
                if current_atlas_key ~= "gamepad_ui" then
                    return original_asset_atlas[current_atlas_key] or original_asset_atlas["gamepad_ui"]
                end
            end
            return original_asset_atlas[key]
        end,
        __newindex = function(table, key, value)
            original_asset_atlas[key] = value
        end,
        __pairs = function(table)
            return pairs(original_asset_atlas)
        end
    })
    G.ASSET_ATLAS = gamepad_atlas_proxy
end

-- Config Tab Definition
GamepadPrompts.config_tab = function()
    -- Find current controller index
    local current_idx = 1
    for i, controller in ipairs(GamepadPrompts.config.options) do
        if controller == GamepadPrompts.config.controller_type then
            current_idx = i
            break
        end
    end

    return {
        n = G.UIT.ROOT,
        config = {align = "tm", r = 0.1, padding = 0.3},
        nodes = {
            -- Controller Selection
            create_option_cycle({
                label = 'Controller Icons',
                scale = 0.8,
                w = 4,
                options = GamepadPrompts.config.options,
                opt_callback = 'gpp_select_controller',
                current_option = current_idx,
            })
        }
    }
end

-- Callback function for controller selection (updated to use built-in system)
function G.FUNCS.gpp_select_controller(e)
    local selected_controller = GamepadPrompts.config.options[e.to_key]
    GamepadPrompts.config.controller_type = selected_controller
    
    -- Update the game's controller graphics using built-in system
    update_controller_graphics(selected_controller)
    
    -- Save config
    SMODS.save_mod_config(GamepadPrompts)
end

-- Initialize with saved controller setting
update_controller_graphics(GamepadPrompts.config.controller_type)

-- Initialize the Mod
sendDebugMessage("Current controller: " .. tostring(GamepadPrompts.config.controller_type))
sendDebugMessage("Tooltips enabled: " .. tostring(GamepadPrompts.config.tooltips))
sendDebugMessage("Gamepad Prompts Mod Initialized Successfully!")

----------------------------------------------
------------MOD CODE END----------------------
