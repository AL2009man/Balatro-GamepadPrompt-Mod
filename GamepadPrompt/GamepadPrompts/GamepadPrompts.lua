--- STEAMODDED HEADER
--- MOD_NAME: Gamepad Prompts
--- MOD_ID: GamepadPrompts
--- MOD_AUTHOR: [AL2009man]
--- MOD_DESCRIPTION: This is a simple mod that replaces the bake-in Xbox prompts with a more Automated Detection system.
--- BADGE_COLOUR: 6C6D70
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]
--- VERSION: 1.0.1

----------------------------------------------
------------MOD CODE -------------------------


sendDebugMessage("Launching Gamepad Button Prompt Icon!")

SMODS.Atlas{key = "gamepad_ui", path = "gamepad_ui.png", px = 32, py = 32, prefix_config = { key = false } }

----------------------------------------------
------------MOD CODE END----------------------