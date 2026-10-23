-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },

  -- Systems
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.cpp" }, -- C and C++ (clangd + codelldb)

  -- Python: basedpyright for types, ruff for lint + format
  { import = "astrocommunity.pack.python.base" },
  { import = "astrocommunity.pack.python.basedpyright" },
  { import = "astrocommunity.pack.python.ruff" },

  -- Web: JS/TS/React (vtsls), Vue (volar), formatting
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.prettier" },

  -- JVM
  { import = "astrocommunity.pack.java" },

  -- Shell & infra
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.terraform" }, -- HCL / Terraform
  { import = "astrocommunity.pack.docker" },

  -- Config / data files
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.markdown" },
}
