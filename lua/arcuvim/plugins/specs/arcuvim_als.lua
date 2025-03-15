return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				event = "VeryLazy",
				opts = {},
			},
			{
				"williamboman/mason-lspconfig.nvim",
			},
			{
				"nvimtools/none-ls.nvim",
			},
			{
				"jay-babu/mason-null-ls.nvim",
				opts = {},
			},
			{
				"hrsh7th/nvim-cmp",
				dependencies = {
					{
						"hrsh7th/cmp-nvim-lsp",
					},
					{
						"hrsh7th/cmp-nvim-lua",
					},
					{
						"hrsh7th/cmp-buffer",
					},
					{
						"hrsh7th/cmp-path",
					},
					{
						"hrsh7th/cmp-cmdline",
					},

					{
						"petertriho/cmp-git",
					},
					{
						"hrsh7th/cmp-calc",
					},
					{
						"zbirenbaum/copilot.lua",
						cmd = "Copilot",
						event = "InsertEnter",
						opts = {},
					},
					{
						"CopilotC-Nvim/CopilotChat.nvim",
						dependencies = {
							{ "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
							{ "nvim-telescope/telescope.nvim" },
							{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
						},
						build = "make tiktoken", -- Only on MacOS or Linux
						opts = {
							-- See Configuration section for options
						},
						keys = require("arcuvim.plugins.configs.arcuvim_als").copilot_chat__keys(),
						-- See Commands section for default commands if you want to lazy load on them
					},
					{
						"zbirenbaum/copilot-cmp",
						after = "copilot.lua",
						opts = {},
					},
				},
			},

			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				dependencies = {
					{ "rafamadriz/friendly-snippets" },
					{
						"saadparwaiz1/cmp_luasnip",
					},
				},
			},

			{
				"smjonas/inc-rename.nvim",
				keys = {
					{
						mode = "n",
						"<leader>rn",
						function()
							return ":IncRename " .. vim.fn.expand("<cword>")
						end,
						expr = true,
						desc = "LSP based incremental Rename",
					},
				},
			},
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			{
				"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			},
			{
				"nvimdev/lspsaga.nvim",
				dependencies = {
					"nvim-treesitter/nvim-treesitter", -- optional
					"nvim-tree/nvim-web-devicons", -- optional
				},
			},
			{
				"onsails/lspkind.nvim",
			},
			{
				"simrat39/inlay-hints.nvim",
				opts = {},
			},
			{ "ray-x/lsp_signature.nvim" },
			{
				"VidocqH/lsp-lens.nvim",
                opts = {}
			},
            {
                'dnlhc/glance.nvim',
                cmd = 'Glance'
            },
		},
		config = function()
			require("arcuvim.plugins.configs.arcuvim_als").setup()
		end,
	},
}
