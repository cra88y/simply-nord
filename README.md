# Simply Nord - a minimalist theme for Searxng
Supports dark, light, and OLED black modes.

- UI fixes and reworks for:
  - mobile layout issues (like all horizontal scrolling bugs!)
  - autocomplete behavior
  - suggestions for search
  - answer/info boxes
  - results view
  - image view
  - video view
  - news view
Note: Some features may be hidden or moved or changed

  
16: Simple to use by generating the finished theme and adding the binds to your Searxng docker compose yml.
17: 
18: ### 1. Build the Theme
19: Run the build script to combine vanilla SearXNG with Nord overrides:
20: ```powershell
21: powershell -File .\make-nord-theme.ps1
22: ```
23: 
24: ### 2. Configure Docker
25: Add these volumes to your `docker-compose.yml`:
26: ```yaml
27: services:
28:   searxng:
29:     volumes:
30:       - ./dist/crabx:/usr/local/searxng/searx/templates/simple
31:       - ./dist/crabx-static/css:/usr/local/searxng/searx/static/themes/simple/css
32: ```
33: 
34: ### 🔄 Maintenance
35: To update when SearXNG releases a new version:
36: 1. Update the vanilla SearXNG repo in `c:\Users\cra88y\.gemini\searxng-vanilla`.
37: 2. Re-run `.\make-nord-theme.ps1`.
38: 3. Restart Docker.
39: 
40: Note: Your custom Nord colors and CSS removals are managed in `nord-crab-overrides.less`.
41: 
