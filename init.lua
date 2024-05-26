-- 1. NVim Options
-- 1.1. General
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes:1'
vim.opt.statuscolumn = '%s%r %l '
vim.opt.mouse = 'a'
vim.opt.smartcase = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.spell = true
vim.opt.spelllang = 'en_us'
vim.opt.syntax = 'on'
vim.opt.scrolloff = 12
vim.opt.sidescrolloff = 8
vim.opt.updatetime = 50
vim.opt.timeoutlen = 500
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = false
vim.opt.splitkeep = 'screen'
vim.opt.inccommand = 'split'
vim.opt.laststatus = nil
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.ruler = false
vim.opt.cursorline = false
vim.opt.showmode = false
vim.opt.showcmd = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.list = true
vim.opt.listchars = {tab = '» ', trail = '·', nbsp = '␣', multispace = '---+'}
vim.diagnostic.config({float = {border = 'rounded'}})
vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'
vim.opt.undofile = true
vim.g.mapleader = ' '
vim.g.have_nerd_font = true -- For the lualine plugin
vim.keymap.set('n', '<leader>fx', vim.cmd.Ex, {desc = 'To open [F]ile [X]plorer (netrw)'})
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, {desc = 'Go to [P]revious [D]iagnostic message'})
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, {desc = 'Go to [N]ext [D]iagnostic message'})
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, {desc = 'Show [D]iagnostic [E]rror messages'})
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, {desc = 'Open [D]iagnostic [Q]uickfix list'})
vim.keymap.set('n', '<leader>wh', '<C-w><C-h>', {desc = 'Move focus to the left [H] [W]indow'})
vim.keymap.set('n', '<leader>wl', '<C-w><C-l>', {desc = 'Move focus to the right [L] [W]indow'})
vim.keymap.set('n', '<leader>wj', '<C-w><C-j>', {desc = 'Move focus to the lower [J] [W]indow'})
vim.keymap.set('n', '<leader>wk', '<C-w><C-k>', {desc = 'Move focus to the upper [K] [W]indow'})

-- 2. Autocommands
-- 2.1. Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {desc = 'Highlight when yanking (copying) text', group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {clear = true}),
  pattern = '*',
  callback = function()
      vim.highlight.on_yank({higroup = 'Search', timeout = 200})
  end
})

-- 3. Plugins (Lazy.nvim)
-- 3.1. Lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- 3.2. Plugins configuration
local plugins = {
  {'neovim/nvim-lspconfig'},
  {'williamboman/mason.nvim',
    name = 'mason',
    opts = {ui =
    {border = 'rounded'}}},
  {'williamboman/mason-lspconfig.nvim',
    name = 'mason-lspconfig'},
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'saadparwaiz1/cmp_luasnip'},
  {'L3MON4D3/LuaSnip'},
  {'rafamadriz/friendly-snippets'},
  {'nvim-telescope/telescope.nvim',
    name = 'telescope',
    branch = '0.1.x',
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = '[F]ind normal [F]iles'})
      vim.keymap.set('n', '<leader>fg', builtin.git_files, {desc = '[F]ind [G]it files'})
      vim.keymap.set('n', '<leader>fr', function() builtin.grep_string({search = vim.fn.input('Grep Search >> ')}); end, {desc = '[F]ind G[R]ep string'})
    end},
    {'catppuccin/nvim',
      name = 'catppuccin',
      priority = 1000,
      config = function()
        vim.cmd.colorscheme 'catppuccin-mocha'
        vim.api.nvim_set_hl(0, 'Normal', {bg = '#1e1e1e'})
        vim.api.nvim_set_hl(0, 'NormalFloat', {bg = '#1e1e1e'})
        vim.api.nvim_set_hl(0, 'NormalNC', {bg = '#1e1e1e'})
        vim.api.nvim_set_hl(0, 'NormalSB', {bg = '#1e1e1e'})
      end},
    {'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        local configs = require('nvim-treesitter.configs')
        configs.setup({
          ensure_installed = {'c', 'cpp', 'lua', 'go', 'gomod', 'gosum', 'html', 'css', 'python', 'vimdoc', 'markdown_inline'},
          sync_install = false,
          highlight = {enable = true, additional_vim_regex_highlighting = true}})
      end},
    {'mbbill/undotree',
      config = function()
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, {desc = 'Toggle [U]ndotree'})
      end},
    {'nvim-lualine/lualine.nvim',
      dependencies = {'nvim-tree/nvim-web-devicons'},
      config = function()
        local lualine = require('lualine')
        local caseFormat = function(str)
          return str:sub(1,1):upper()..str:sub(2)
        end
        local custom_theme = function()
          local color_palette = {rosewater = '#f5e0dc', flamingo = '#f2cdcd', pink = '#f5c2e7', mauve = '#cba6f7', red = '#f38ba8', maroon = '#eba0ac', peach = '#fab387', yellow = '#f9e2af', green = '#a6e3a1', teal = '#94e2d5', sky = '#89dceb', sapphire = '#74c7ec', blue = '#89b4fa', lavender = '#b4befe', text = '#cdd6f4', subtext1 = '#bac2de', subtext0 = '#a6adc8', overlay2 = '#9399b2', overlay1 = '#7f849c', overlay0 = '#6c7086', surface2 = '#585b70', surface1 = '#45475a', surface0 = '#313244', base = '#1e1e2e', mantle = '#181825', crust = '#11111b'}
          local transparent_bg = '#1e1e1e'
          local catppuccin = {}
          catppuccin.normal = {a = {bg = color_palette['blue'], fg = color_palette['mantle'], gui = "bold"}, b = {bg = color_palette['surface0'], fg = color_palette['blue']}, c = {bg = transparent_bg, fg = color_palette['text']}}
          catppuccin.insert = {a = {bg = color_palette['green'], fg = color_palette['base'], gui = "bold"}, b = {bg = color_palette['surface0'], fg = color_palette['green']}}
          catppuccin.terminal = {a = {bg = color_palette['green'], fg = color_palette['base'], gui = "bold"}, b = {bg = color_palette['surface0'], fg = color_palette['green']}}
          catppuccin.command = {a = {bg = color_palette['peach'], fg = color_palette['base'], gui = "bold"},b = {bg = color_palette['surface0'], fg = color_palette['peach']}}
          catppuccin.visual = {a = {bg = color_palette['mauve'], fg = color_palette['base'], gui = "bold"}, b = {bg = color_palette['surface0'], fg = color_palette['mauve']}}
          catppuccin.replace = {a = {bg = color_palette['red'], fg = color_palette['base'], gui = "bold"}, b = {bg = color_palette['surface0'], fg = color_palette['red']}}
          catppuccin.inactive = {a = {bg = transparent_bg, fg = color_palette['blue']}, b = {bg = transparent_bg, fg = color_palette['surface1'], gui = "bold"}, c = {bg = transparent_bg, fg = color_palette['overlay0']}}
          return catppuccin
        end
        lualine.setup({
          options = {
            theme = custom_theme,
            section_separators = {left = '', right = ''},
            component_separators = ''},
          sections = {
            lualine_a = {{function()
              local mode = {['n'] = 'N', ['no'] = 'PD', ['nov'] = 'PD', ['noV'] = 'PD', ['no\22'] = 'PD', ['niI'] = 'N', ['niR'] = 'N', ['niV'] = 'N', ['nt'] = 'N', ['ntT'] = 'N', ['v'] = 'V', ['vs'] = 'V', ['V'] = 'V-LINE', ['Vs'] = 'V-LINE', ['\22'] = 'V-BLOCK', ['\22s'] = 'V-BLOCK', ['s'] = 'S', ['S'] = 'S-LINE', ['\19'] = 'S-BLOCK', ['i'] = 'I', ['ic'] = 'I', ['ix'] = 'I', ['R'] = 'R', ['Rc'] = 'R', ['Rx'] = 'R', ['Rv'] = 'V-REPLACE', ['Rvc'] = 'V-REPLACE', ['Rvx'] = 'V-REPLACE', ['c'] = 'CMD', ['cv'] = 'EX', ['ce'] = 'EX', ['r'] = 'R', ['rm'] = 'MORE', ['r?'] = 'CMD', ['!'] = 'SHELL', ['t'] = 'TERM'}
              if mode[vim.api.nvim_get_mode().mode] == nil then
                return vim.api.nvim_get_mode().mode
              end
              return mode[vim.api.nvim_get_mode().mode]
            end, separator = {right = '', left = ''}, padding = 0}},
            lualine_b = {'branch', {'diagnostics',
              sources = {'nvim_diagnostic'},
              symbols = {error = ' ', warn = ' ', info = ' '},
              diagnostics_color = {
                color_error = {fg = '#f38ba8'},
                color_warn = {fg = '#f9e2af'},
                color_info = {fg = '#89b4fa'}}}},
            lualine_c = {'%=', {'filename', color = {bg = '#313244', fg = '#89b4fa'}, separator = {right = "", left = ""}, path = 4, icon = ''}},
            lualine_x = {{'o:encoding', fmt = string.upper}, {'fileformat', symbols = {unix = ' Unix-LF', dos = ' Win-CRLF', mac = ' Mac-CR'}}},
            lualine_y = {{'diff',
              symbols = {added = ' ', modified = '󰝤 ', removed = ' '},
              diff_color = {
                added = {fg = '#a6e3a1'},
                modified = {fg = '#fab387'},
                removed = {fg = '#f38ba8'}}, separator = '│'}, {'filesize', separator = '│'}, {'filetype', fmt = function(str)
                  local msg = ''
                  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                  local clients = vim.lsp.get_active_clients()
                  str = caseFormat(str)
                  if str == '' then
                    return 'Text' .. ' - ' .. 'LSP N/A'
                  end
                  if next(clients) == nil then
                    return str .. ' - ' .. 'LSP N/A'
                  end
                  for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                      return str .. ' - ' .. client.name
                    end
                  end
                  return str .. ' - ' .. msg
                  end}},
            lualine_z = {{'location', separator = {left = '', right = ''}, padding = 0}}},
          inactive_sessions = {
            lualine_c = {'filename'},
            lualine_x = {'location'}}})
      end},
      {'tpope/vim-fugitive',
      config = function()
        vim.keymap.set('n', '<leader>gi', vim.cmd.Git, {desc = '[Gi]t information'})
      end},
      {'lewis6991/gitsigns.nvim',
      opts = {
        signs = {
          add = {text = '+'},
          change = {text = '~'},
          delete = {text = '-'},
          topdelete = {text = '‾'},
          changedelete = {text = '~'}}}},
      {'numToStr/Comment.nvim',
        opts = {}},
      {'folke/which-key.nvim',
      config = function()
        local registration = {['<leader>'] = {f = {name = 'Files/Find files'}, d = {name = 'Diagnostics'}, w = {name = 'Window'}, g = {name = 'Git'}, l = {name = 'Lsp'}}}
        require('which-key').register(registration)
      end},
      {'iamcco/markdown-preview.nvim',
      cmd = {'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop'},
      build = 'cd app && npm install',
      init = function()
        vim.g.mkdp_filetypes = {"markdown"}
      end,
      ft = {"markdown"}}}

--3.3. Lazy configuration
local conf = {ui = {border = 'rounded'}, lazy = true}
-- 3.4. Lazy setup
require('lazy').setup(plugins, conf)

-- 4. LSP configuration
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
  callback = function(event)
    vim.keymap.set('n', '<leader>ld', function() vim.lsp.buf.definition() end, {buffer = event.buf, desc = '[L]SP [D]efinition'})
    vim.keymap.set('n', '<leader>lh', function() vim.lsp.buf.hover() end, {buffer = event.buf, desc = '[L]SP [H]over'})
    vim.keymap.set('n', '<leader>lw', function() vim.lsp.buf.workspace_symbol() end, {buffer = event.buf, desc = '[L]SP [W]orkspace Symbol'})
    vim.keymap.set('n', '<leader>lf', function() vim.diagnostic.open_float() end, {buffer = event.buf, desc = '[L]SP [F]loat Diagnostics'})
    vim.keymap.set('n', '<leader>lc', function() vim.lsp.buf.code_action() end, {buffer = event.buf, desc = '[L]SP [C]ode Action'})
    vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.references() end, {buffer = event.buf, desc = '[L]SP Re[F]erences'})
    vim.keymap.set('n', '<leader>lr', function() vim.lsp.buf.rename() end, {buffer = event.buf, desc = '[L]SP [R]ename'})
  end,})
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'gopls', 'clangd', 'lua_ls', 'html', 'cssls', 'pyright', 'vimls',},
  handlers = {function(server_name)
    require('lspconfig')[server_name].setup({
      capabilities = lsp_capabilities})
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'},
            diagnostics = {
              globals = {'vim'}},
            workspace = {
              library = {
                vim.env.VIMRUNTIME}}}}})
    end}})
local cmp = require('cmp')
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}
require('luasnip.loaders.from_vscode').lazy_load()
cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'buffer', keyword_length = 3}},
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<C-z>'] = cmp.mapping.abort()}),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end}})
