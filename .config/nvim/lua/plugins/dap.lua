-- nvim-dap has no setup() function. The lang extras (lang.java, lang.kotlin)
-- attach `opts` to nvim-dap, which makes lazy.nvim fall back to its default
-- config path -- require("dap").setup(opts) -- and crash on every startup,
-- since dap.core (which would give nvim-dap a real config) isn't enabled.
--
-- An explicit no-op config short-circuits that default path. The java/kotlin
-- dap.configurations still register via their opts functions.
return {
  { "mfussenegger/nvim-dap", config = function() end },
}
