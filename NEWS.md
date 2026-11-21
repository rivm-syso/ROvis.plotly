# ROvis.plotly (development version)

### :hammer_and_wrench: Changed

- **Breaking:** `ro_ply_theme()` now takes the figure as its first argument and returns it
  styled, like `ro_gg_theme()`, `ro_gt_theme()` and `ro_e_theme()`, instead of returning a
  theme list. Replace `ro_ply_add_theme(fig, ro_ply_theme(...))` with `ro_ply_theme(fig, ...)`.
- Removed the vignettes "plotly figures in Rijksoverheid style" and "ggplotly and plotly
  keyboard accessibility"; the remaining vignette is built around `ro_ply_standard()`.

### :coffin: Deprecated

- **Breaking:** `ro_ply_add_theme()` is removed; `ro_ply_theme(fig, ...)` applies the theme
  directly.
- **Breaking:** `ro_ply_cursor()`, `ro_ply_dim()`, `ro_ply_disable_toolbar()`,
  `ro_ply_legend_theme()`, `ro_ply_title()` and the keyboard navigation functions
  (`ro_ply_keyboard_nav_barchart()`, `ro_ply_keyboard_nav_bargraph()`,
  `ro_ply_keyboard_nav_linechart()`, `ro_ply_keyboard_nav_trendline()`,
  `ro_ply_keyboard_nav_legend()`) are now internal. `ro_ply_standard()` applies all of them;
  use `ro_ply_theme()` for styling only.

# ROvis.plotly 0.1.0

First release since `ROvis.plotly` was split out of the `ROvis` monolith into its own
package, and the repository moved from GitLab to GitHub.

### :sparkles: Added

- Moved the plotly functions from ROvis: `ro_ply_add_theme`, `ro_ply_cursor`,
`ro_ply_dim`, `ro_ply_disable_toolbar`, `ro_ply_focus_linechart`,
`ro_ply_keyboard_nav_barchart`, `ro_ply_keyboard_nav_bargraph`,
`ro_ply_keyboard_nav_legend`, `ro_ply_keyboard_nav_linechart`,
`ro_ply_keyboard_nav_trendline`, `ro_ply_legend_theme`, `ro_ply_theme`, `ro_ply_title`.

### :hammer_and_wrench: Changed

- Migrated the repository from GitLab to GitHub (`rivm-syso/ROvis.plotly`).

### :bug: Fixed 

### :coffin: Deprecated
