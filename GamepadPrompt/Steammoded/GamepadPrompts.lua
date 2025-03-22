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

-- Load Configurations from config.lua
local config_path = "Mods/GamepadPrompts/config.lua"
GamepadPrompts.config = dofile(config_path) or {
    options = {"Xbox", "DualSense", "DualShock4", "NintendoSwitch", "SteamDeck"}
}

-- Default Texture and Controller
local default_texture = "gamepad_ui.png"
GamepadPrompts.current_controller = GamepadPrompts.current_controller or "Xbox"

-- Base Paths for Controllers
local controller_paths = {
    Xbox = "glyphs/Xbox/assets/",
    DualSense = "glyphs/DualSense/assets/",
    DualShock4 = "glyphs/DualShock4/assets/",
    NintendoSwitch = "glyphs/NintendoSwitch/assets/",
    SteamDeck = "glyphs/SteamDeck/assets/"
}

-- Function to Update Controller Texture
function update_controller_texture(controller_type)
    local base_path = controller_paths[controller_type]
    local texture_path = base_path .. default_texture

    if file_exists(texture_path) then
        SMODS.Atlas{
            key = "gamepad_ui",
            path = texture_path,
            px = 32,
            py = 32,
            prefix_config = {key = false}
        }
        sendDebugMessage("Controller texture loaded: " .. texture_path)
    else
        sendDebugMessage("Error: Texture not found for controller: " .. controller_type)
    end
end

-- Helper Function: Check if File Exists
function file_exists(path)
    local file = io.open(path, "r")
    if file then
        file:close()
        return true
    else
        return false
    end
end

-- Config Tab Definition
GamepadPrompts.config_tab = function()
    local tabs = create_tabs({
        tabs = {
            {
                label = localize("tabs_controller_selection"),
                chosen = true,
                tab_definition_function = function()
                    -- Create Slider Node
                    local controller_slider_node = {
                        n = G.UIT.SLIDER,
                        config = {
                            text = "Controller Icons",
                            options = GamepadPrompts.config.options,
                            align = "cm",
                            scale = 1,
                            arrow_left = true,
                            arrow_right = true
                        },
                        callback = function(option_index)
                            local selected_controller = GamepadPrompts.config.options[option_index]
                            GamepadPrompts.config.controller_type = selected_controller
                            sendDebugMessage("Controller selected: " .. selected_controller)
                            update_controller_texture(selected_controller)
                        end
                    }

                    -- Validate Slider Node
                    if type(controller_slider_node) ~= "table" or not controller_slider_node.n then
                        sendDebugMessage("Error: Invalid slider node.")
                        return {
                            n = G.UIT.ROOT,
                            config = {text = "Error in slider node.", colour = G.C.RED},
                            nodes = {}
                        }
                    end

                    -- Return UI Definition
                    return {
                        n = G.UIT.ROOT,
                        config = {align = "tm", r = 0.1, padding = 0.3},
                        nodes = {controller_slider_node}
                    }
                end
            }
        }
    })

    -- Debug Tabs
    if type(tabs) ~= "table" then
        sendDebugMessage("Error: Tabs structure is invalid.")
    end

    return tabs
end

-- Initialize the Mod
update_controller_texture(GamepadPrompts.current_controller)
sendDebugMessage("Gamepad Prompts Mod Initialized Successfully!")


----------------------------------------------
------------MOD CODE END----------------------
