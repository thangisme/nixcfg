version = '0.21.9'
xplr.config.layouts.builtin.default = {
  Horizontal = {
    config = {
      constraints = {
        { Percentage = 70 },
        { Percentage = 30 },
      },
    },
    splits = {
      {
        Vertical = {
          config = {
            constraints = {
              { Length = 3 },
              { Min = 1 },
              { Length = 3 },
            },
          },
          splits = {
            "SortAndFilter",
            "Table",
            "InputAndLogs",
          },
        },
      },
      "Selection",
    },
  },
}

local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path
  .. ";"
  .. xpm_path
  .. "/?.lua;"
  .. xpm_path
  .. "/?/init.lua"

os.execute(
  string.format(
    "[ -e '%s' ] || git clone '%s' '%s'",
    xpm_path,
    xpm_url,
    xpm_path
  )
)

require("xpm").setup({
  plugins = {
    -- Let xpm manage itself
    'dtomvan/xpm.xplr',
    { name = 'sayanarijit/fzf.xplr' },
    'Junker/nuke.xplr',
    'sayanarijit/tree-view.xplr',
    'prncss-xyz/icons.xplr',
    'sayanarijit/zoxide.xplr'
  },
  auto_install = true,
  auto_cleanup = true,
})

local key = xplr.config.modes.builtin.default.key_bindings.on_key

key.x = {
  help = "xpm",
  messages = {
    "PopMode",
    { SwitchModeCustom = "xpm" },
  },
}

require("fzf").setup{
  mode = "default",
  key = "ctrl-f",
  bin = "fzf",
  args = "--preview 'pistol {}'",
  recursive = true,  -- If true, search all files under $PWD
  enter_dir = true,  -- Enter if the result is directory
}

require("nuke").setup{
  pager = "more", -- default: less -R
  open = {
    run_executables = true, -- default: false
    custom = {
      {extension = "jpg", command = "imv {}"},
      {extension = "png", command = "imv {}"},
      {mime = "video/mp4", command = "mpv {}"},
      {mime_regex = "^video/.*", command = "mpv {}"},
      {mime_regex = ".*", command = "xdg-open {}"}
    }
  },
  view = {
    show_line_numbers = true, -- default: false
  },
  smart_view = {
    custom = {
      {extension = "so", command = "ldd -r {} | less"},
    }
  }
}

key.v = {
   help = "nuke",
   messages = {"PopMode", {SwitchModeCustom = "nuke"}}
}
key["f3"] = xplr.config.modes.custom.nuke.key_bindings.on_key.v
key["enter"] = xplr.config.modes.custom.nuke.key_bindings.on_key.o


require("tree-view").setup({
    mode = "switch_layout",
    key = "T",

    -- If you feel slowness, you might want to toggle back to the default view.
    toggle_layout_mode = "default",
    toggle_layout_key = "esc",

    -- Press backspace to close all and back and close
    close_all_and_back_mode = "default",
    close_all_and_back_key = "backspace",

    -- Toggle expansion without entering
    toggle_expansion_mode = "default",
    toggle_expansion_key = "o",

    -- Toggle expansion of all the nodes under pwd
    toggle_expansion_all_mode = "default",
    toggle_expansion_all_key = "O",

    -- Focus on the next visible line, not compatible with up/down action
    focus_next_mode = "default",
    focus_next_key = "]",

    -- Focus on the previous visible line, not compatible with up/down action
    focus_prev_mode = "default",
    focus_prev_key = "[",

    -- Go to the next deep level directory that's open
    goto_next_open_mode = "default",
    goto_next_open_key = ")",

    -- Go to the previous deep level directory that's open
    goto_prev_open_mode = "default",
    goto_prev_open_key = "(",

    -- Whether to display the tree in full screen
    fullscreen = false,

    -- Indent for the branches of the tree
    indent = "  ",

    -- Start xplr with tree view layout
    as_initial_layout = false,

    -- Disables toggling layout.
    as_default_layout = false,

    -- Automatically fallback to this layout for better performance if the
    -- branch contains # of nodes more than the threshold value
    fallback_layout = "Table",
    fallback_threshold = 500,  -- default: nil (disabled)
})

require"icons".setup()


require("zoxide").setup{
  bin = "zoxide",
  mode = "default",
  key = "Z",
}
