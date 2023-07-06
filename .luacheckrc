self = false
codes = true
max_line_length = false
unused_args = false

include_files = {
  ".busted",
  ".luacheckrc",
  "**/*.lua",
}

exclude_files = {
  ".luarocks/*",
  "dist",
  ".git/*",
  ".vscode/*",
  "node_modules/*",
  ".lua/*",
}

globals = {
  "gg"
}
