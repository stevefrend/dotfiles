-- Silence markdownlint diagnostics on Markdown files.
--
-- LazyVim's `lang.markdown` extra registers `markdownlint-cli2` as an nvim-lint
-- linter for the markdown / markdown.mdx filetypes. That linter is what paints
-- the inline MD013/MD022/MD034/MD058 (line-length, blanks-around-headings,
-- bare-urls, blanks-around-tables) noise over docs. We don't want those visuals.
--
-- This only removes the *diagnostics* (nvim-lint). Formatting is untouched:
-- conform still formats markdown via prettierd/prettier (see prettier.lua), and
-- the markdownlint-cli2 *formatter* in the markdown extra is a no-op now because
-- its condition only fires when markdownlint diagnostics exist -- and there are
-- none once we stop linting.

return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      if opts.linters_by_ft then
        opts.linters_by_ft.markdown = nil
        opts.linters_by_ft["markdown.mdx"] = nil
      end
    end,
  },
}
