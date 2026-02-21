return function()
  ---@diagnostic disable-next-line: missing-fields
  require('kanagawa').setup {
    styles = {
      commentStyle = { italic = false },
    },
  }
end

-- vim: ts=2 sts=2 sw=2 et
