# Balatro-GamepadPrompt-Mod

Unfinished mod. please come back later....however: [you could try out the mod right away](https://github.com/AL2009man/Balatro-GamepadPrompt-Mod/releases) 

----

Finally got the chance to try out Balatro, and after playtesting its Controller Support: I can  I can confirm it relies on SDL2 to handle general controller support, but it only shows Xbox prompts.

What if I told you there are additional button prompts leftover from the PC Version? Unfortunately, it's true, and you can find them within the source code files. 

![image](https://github.com/user-attachments/assets/97c0b00c-b1cb-4460-8c5a-645e028cdcab)

This is a strange omission, given they're using SDL and [SDL GameController Database](https://github.com/mdqinc/SDL_GameControllerDB) to do the heavy-lifting-- you would expect them to use `SDL_GameControllerGetButton`, but nope: it'll always shows Xbox button prompts.

But given how surprisingly moddable Balatro is: I decided to create a simple mod that replaces Xbox button prompts with DualShock 4, DualSense, Nintendo Switch Pro Controller and Steam Deck. All button image assets are taken straight from the source files, and then modified. in Steam Deck's case: it's combined with PlayStation and Nintendo prompts.

![balatro gamepad prompt mod](https://github.com/user-attachments/assets/746d7e75-1e31-4620-9663-e65fefc01044)


# Installation

### Pre-requisite:

I highly suggest copying the Balatro.exe file as a backup in case it doesn't work. Also, if a game update comes out, **the modded prompts will be overridden**. if you wanna apply the same mod again: you'll have to go redo the entire step.


## Method 1: Direct Patch
Due to copyright-related issues, I won't be able to provide you with the .exe file, as it contains the entire source code. Thus, I will teach you how to apply the customized button prompts.

1. download any File Archivers programs (ideally: [7Zip](https://www.7-zip.org/) or [NanaZip](https://github.com/M2Team/NanaZip))
2. Open `Balatro.exe` as a Archive/Open inside.
3. Hover straight into `resources` > `textures`
4. Now go back to your Downloaded button prompt folder, pick one of the Button Prompt folders, and drag-and-drop both `1x` and `2x` files inorder to override them, or manually override `gamepad_ui.png` file for both `1x` and `2x` files

# UnInstallation

Two options:

1. delete Balatro.exe completely and Verify game integrity (on your storefront's properties)
2. take your existing Balatro.exe backup and drag it over to the game directory.
