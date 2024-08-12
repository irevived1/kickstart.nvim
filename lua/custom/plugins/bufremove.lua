local function miniDeleteBuffer()
  local bd = require('mini.bufremove').delete
  if vim.bo.modified then
    local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
    if choice == 1 then -- Yes
      vim.cmd.write()
      bd(0)
    elseif choice == 2 then -- No
      bd(0, true)
    end
  else
    bd(0)
  end
end

return {
  {
    'echasnovski/mini.bufremove',
    keys = {
      {
        '<leader>bd',
        miniDeleteBuffer,
        desc = 'Delete Buffer',
      },
      {
        'œ',
        miniDeleteBuffer,
        desc = 'Delete Buffer',
      },
    -- stylua: ignore
    { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
}
