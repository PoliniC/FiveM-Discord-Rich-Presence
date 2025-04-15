# 📦 Discord Rich Presence - Standalone | ESX / QB / Fake Players Compatible

A fully standalone and optimized Discord Rich Presence script for **FiveM**, with automatic framework detection and compatibility with **fake players (FiveMUP)** systems.

## ✅ Features

- 🔁 **Dynamic player count** (uses `GetNumPlayerIndices()` from the server)
- 📦 **Queue size support** (compatible with `n4_queue`, auto-detected)
- 👤 **Character name detection**:
  - ESX: shows `firstName lastName`
  - QB-Core: shows `charinfo.firstname lastname`
  - Fallback: shows default FiveM player name
- 🧭 **Street name detection** (shows the player's current street or zone)
- 🖼️ **Large & small icons support** (Rich Presence assets)
- 🔘 **Two clickable buttons** (Discord, Tebex, etc.)
- ⚙️ Fully configurable via `config.lua`
- 🌐 **Supports fake player systems (FiveMUP)** - accurate player count

## 🧠 Framework Detection

This script auto-detects the server framework at runtime:
- `es_extended`
- `qb-core`
- Or falls back to standalone (no framework)

No configuration required — it just works.

## 📁 File Structure

```
discord_presence/
├── fxmanifest.lua
├── config.lua
├── client.lua
└── server.lua
```

## 📸 Example Display in Discord

```
Players: 72/128 | Queue Size: 6
✔ Pedro Ramirez is located in Vespucci Blvd
```

## 🛠 Setup Instructions

1. Upload images to your [Discord Developer Application](https://discord.com/developers/applications) → Rich Presence → Art Assets.
2. Replace `YOUR_DISCORD_APP_ID` in `config.lua` with your real App ID.
3. Customize labels, icons, and URLs in `config.lua`.
4. Drop the folder into your `resources/` directory.
5. Add to `server.cfg`:
   ```
   ensure discord_presence
   ```

## ⚠️ Notes

- Buttons in Rich Presence only appear if your Discord app is **properly configured and not in test mode**.
- Queue size will only appear if you are using `n4_queue`.
- Player name detection works only if the framework is loaded and initialized correctly.

## 💬 Credits

Made with ❤️ by FiveMUP Team  
Contributions and pull requests welcome!
