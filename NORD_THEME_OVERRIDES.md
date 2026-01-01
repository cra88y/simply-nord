# Simply-Nord Theme Overrides

This document describes all the Nord theme customizations applied to the SearXNG `client/simple` theme.

## Overview

This is a comprehensive Nord theme implementation for SearXNG that replaces the default color scheme with the beautiful, arctic-inspired Nord palette. The theme provides both light and dark modes using Nord colors.

## Files Modified

### 1. `client/simple/src/less/definitions.less`

This is the primary file containing all Nord theme overrides.

## Color Palette

The Nord palette is defined with the following LESS variables:

```less
// Polar Night (Dark Colors)
@nord01: #1d2128;  // Extra dark (custom addition)
@nord0: #2e3440;   // Darkest
@nord1: #3b4252;   // Dark
@nord2: #434c5e;   // Medium dark
@nord3: #4c566a;   // Lightest

// Snow Storm (Light Colors)
@nord4: #d8dee9;   // Darkest
@nord5: #e5e9f0;   // Medium
@nord6: #eceff4;   // Purest White

// Frost (Blue/Cyan Tones)
@nord7: #8fbcbb;   // Light Teal/Cyan
@nord8: #88c0d0;   // Medium Blue/Cyan
@nord9: #81a1c1;   // Darker Blue
@nord10: #5e81ac;  // Darkest Blue

// Aurora (Accent Colors)
@nord11: #bf616a;  // Red
@nord12: #d08770;  // Orange
@nord13: #ebcb8b;  // Yellow
@nord14: #a3be8c;  // Green
@nord15: #b48ead;  // Purple/Magenta
```

## Theme Implementations

### Light Theme (`:root`)

#### Base Colors
- **Text**: `@nord1` (Polar Night for readable text)
- **Background**: `@nord6` (Snow Storm - pure white)
- **Mobile Background**: `@nord5` (Slightly darker)
- **Links**: `@nord10` (Frost blue)
- **Visited Links**: `@nord15` (Aurora purple)

#### Component Colors
- **Header/Footer**: `@nord6` background with `@nord4` borders
- **Sidebar**: `@nord5` background with `@nord1` text
- **Buttons**: Primary buttons use `@nord9` (Frost blue), secondary use `@nord4`
- **Search Box**: `@nord6` background with subtle shadow, hovers to `@nord9`
- **Modals**: 
  - Error: `@nord11` (red)
  - Warning: `@nord12` (orange)
  - Success: `@nord14` (green)

#### Results
- **Background**: `@nord6`
- **Links**: `@nord10` (unvisited), `@nord15` (visited)
- **URL text**: `@nord3`
- **Vim selection**: `@nord5`

#### Detail Modal (Dark modal on light page)
- **Background**: `@nord0` (dark)
- **Text**: `@nord4` (light)
- **Links**: `@nord8`

### Dark Theme (`.dark-themes()`)

Applied via:
- `:root.theme-dark` - explicit dark mode
- `:root.theme-auto` - auto-switches based on `prefers-color-scheme: dark`

#### Base Colors
- **Text**: `@nord4` (Snow Storm)
- **Background**: `@nord0` (Polar Night darkest)
- **Links**: `@nord7` (lighter Frost teal)
- **Visited Links**: `@nord15` (Aurora purple)

#### Component Colors
- **Header**: `@nord01` (extra dark) with `@nord1` borders
- **Footer**: `@nord0` with `@nord1` borders
- **Sidebar**: `@nord1` background
- **Buttons**: Primary `@nord9`, secondary `@nord3`
- **Search**: `@nord0` background with stronger shadow
- **Modals**: Same colors but with `@nord2` backgrounds

#### Results
- **Background**: `@nord0`
- **Links**: `@nord8` (unvisited), `@nord12` (visited - orange)
- **URL text**: `@nord5`
- **Engines**: `@nord8`
- **Vim selection**: `@nord2` with 80% opacity

### Black Theme (`.black-themes()`)

Applied via `:root.theme-black` (combines dark theme + pure black)

Replaces various backgrounds with pure `#000` black:
- Base background
- Header/Footer
- Sidebar
- Search box
- Autocomplete
- Answer boxes
- Results
- Detail modals
- Image backgrounds
- Dialogs

## Layout Overrides

In addition to colors, the following layout dimensions were modified:

```less
@results-image-row-height: 15.5rem;  // Changed from 12rem
@search-width: 52rem;                // Changed from 44rem
```

These provide:
- Larger image thumbnails in search results
- Wider search input box

## Key Design Decisions

1. **Light Mode Philosophy**: Uses Snow Storm (`@nord4`, `@nord5`, `@nord6`) for backgrounds and Polar Night (`@nord1`, `@nord2`) for text, creating a clean, bright interface

2. **Dark Mode Philosophy**: Uses Polar Night shades for backgrounds and Snow Storm for text, with Frost colors for interactive elements

3. **Accent Colors**: 
   - Primary actions: Frost blues (`@nord8`, `@nord9`, `@nord10`)
   - Alerts: Aurora colors (red/orange/yellow/green)
   - Links: Frost cyan/teal for better visibility

4. **Consistency**: Both themes use the same Nord palette, just inverted polarity, ensuring visual harmony

5. **Accessibility**: Maintains sufficient contrast ratios by using appropriate Nord color pairings

## Implementation Notes

- All color definitions use LESS variables for easy maintenance
- The theme fully replaces SearXNG's default color scheme
- All CSS custom properties (CSS variables) are overridden at the `:root` level
- The `.dark-themes()` and `.black-themes()` mixins allow clean inheritance
- Nord color functions (like `rgb(red(@nord0) green(@nord0) blue(@nord0) / X%)`) are used for semi-transparent colors

## Future Enhancements

Potential areas for further customization:
- Syntax highlighting colors (pygments.less)
- Code block styling
- Additional result type templates
- Animation timing/easing
- Custom Nord-themed icons

## License

This theme follows the same license as SearXNG (AGPL-3.0-or-later).

## Credits

- Based on the [Nord color palette](https://www.nordtheme.com/) by Arctic Ice Studio
- Implemented for [SearXNG](https://github.com/searxng/searxng)
