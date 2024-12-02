--- STEAMODDED HEADER
--- MOD_NAME: Gamepad Prompts - Steam Deck
--- MOD_ID: GamepadPrompts-SteamDeck
--- MOD_AUTHOR: [AL2009man]
--- MOD_DESCRIPTION: This is a simple mod that replaces Xbox One button prompt textures infavor of Steam Deck prompts.
--- BADGE_COLOUR: "6285EF"
--- DEPENDENCIES: [Steamodded>=0.9.8]
--- VERSION: 0.1.2

----------------------------------------------
------------MOD CODE -------------------------


sendDebugMessage("Launching Gamepad Button Prompt Icon!")

SMODS.Atlas{key = "gamepad_ui", path = "gamepad_ui.png", px = 32, py = 32, prefix_config = { key = false } }

----------------------------------------------
------------MOD CODE END----------------------