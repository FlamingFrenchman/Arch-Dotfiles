--[[
	before changing options, run `:h nvim-defaults` to see if the option has
	already been set by default by nvim. some of the options in my original
	vim/neovim config are unnecessary here.
	also, remember to check out mini.nvim because some of the things in there
	are cool (for example, there's a replacement/equivalent to vim.surround)
]]

vim.opt.guicursor = {
	"n-v-c:block",
	"i-ci-ve:ver25",
	"r-cr:hor20",
	"o:hor50",
	"a:blinkwait0-blinkoff600-blinkon600-Cursor/lCursor",
	"sm:block-blinkwait0-blinkoff600-blinkon600",
}

vim.opt.showmatch = true
vim.opt.showmode = true
vim.opt.lazyredraw = true
vim.opt.magic = true
vim.opt.listchars = {
	eol = "$",
	nbsp = "+",
	tab = "<->",
	trail = "-",
}

vim.opt.mouse = { a = true }
vim.api.nvim_set_keymap("n", "<C-L>", ":nohls<CR>:set nolist<CR><C-L>", { noremap = true, silent = true })

vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.numberwidth = 3
vim.opt.wrap = true
vim.opt.showbreak = "  >"
vim.opt.signcolumn = "yes"
vim.opt.foldenable = false
-- showbreak in gutter
vim.o.cpo = vim.o.cpo .. "n"

-- set filetype for posix/bourne shell rc
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = ".shrc",
	callback = function()
		vim.opt.filetype = "sh"
	end,
})

require("nvim-treesitter.config").setup({
	ensure_install = { "cpp", "bash", "c", "lua", "markdown", "markdown_inline", "vim", "vimdoc" },
	ignore_install = { "unsupported" },
	install_dir = vim.fn.stdpath("data") .. "/site",
})

-- https://stackoverflow.com/questions/78077278/treesitter-and-syntax-folding
-- use treesitter where possible
vim.api.nvim_create_autocmd("Filetype", {
	pattern = {
		"cpp",
		"bash",
		"c",
		"lua",
		"markdown",
		-- "markdown_inline",
		"vim",
		"vimdoc",
	},
	callback = function()
		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.bo.indentexpr = "v:lua.require('nvim_treesitter').indentexpr()"
		vim.treesitter.start()
	end,
})

-- indentation guides and scope outlining
require("ibl").setup()

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig = require("lspconfig")
local lspconfig_defaults = lspconfig.util.default_config
lspconfig_defaults.capabilities =
	vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
		vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	end,
})

-- You'll find a list of language servers here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

lspconfig.ccls.setup({})
lspconfig.bashls.setup({})

-- make LuaLS work nicely with neovim apis
-- NOTE: consider lazydev.nvim instead of manually specifying library paths
lspconfig.lua_ls.setup({
	on_init = function(client)
		-- don't do this if there's a lua_ls configuration file
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					vim.fn.stdpath("config"),
					-- luvit type definitions
					vim.fn.stdpath("data") .. "/site/pack/lsp/start/luvit-meta",
					-- lsp/completion related lua plugins
					vim.fn.stdpath("data") .. "/site/pack/lsp/start/nvim-lspconfig",
					vim.fn.stdpath("data") .. "/site/pack/lsp/start/nvim-cmp",
					vim.fn.stdpath("data") .. "/site/pack/lsp/start/luasnip",
					vim.fn.stdpath("data") .. "/site/pack/lsp/start/cmp-lsp",
					vim.fn.stdpath("data") .. "/site/pack/lsp/start/cmp-luasnip",
					vim.fn.stdpath("data") .. "/site/pack/lsp/start/lsp-zero",
					-- other plugins
					vim.fn.stdpath("data") .. "/site/pack/treesitter/start/nvim-treesitter",
					vim.fn.stdpath("data") .. "/site/pack/treesitter/start/nvim-treesitter-textobjects",
					vim.fn.stdpath("data") .. "/site/pack/plugins/start/indent-blankline",
					vim.fn.stdpath("data") .. "/site/pack/plugins/start/nvim-surround",
					vim.fn.stdpath("data") .. "/site/pack/plugins/start/mini",
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				},
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true)
			},
		})
	end,
	on_attach = lspconfig.lua_ls.on_attach,
	capabilities = lspconfig.lua_ls.capabilities,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

-- mini.nvim modules
require("mini.ai").setup()
require("mini.trailspace").setup()

-- manipulate surrounding parentheses, brackets, quotes, tags, etc.
require("nvim-surround").setup({})

-- set up nvim-cmp.
local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.setup({})

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	-- window = {
	--   -- completion = cmp.config.window.bordered(),
	--   -- documentation = cmp.config.window.bordered(),
	-- },
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}),
})
