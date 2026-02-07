--------------------------------------------------
-- Lazy.nvim bootstrap
--------------------------------------------------
vim.opt.termguicolors = true
vim.opt.rtp:prepend(vim.fn.expand("~/.local/share/nvim/lazy/lazy.nvim"))

require("lazy").setup({
  {
    "silentium-theme/silentium.nvim",
    lazy = false,
    priority = 1000,
  },

  -- Completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = true,
  },
})

vim.cmd.colorscheme("silentium")

--------------------------------------------------
-- UI
--------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }

local cmp = require("cmp")

cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  },
  sources = {
    { name = "nvim_lsp" },
  },
})

--------------------------------------------------
-- LSP setup
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- C / C++
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.lsp.start({
      name = "clangd",
      cmd = { "clangd" },
      root_dir = vim.fn.getcwd(),
      capabilities = capabilities,
    })
  end,
})
