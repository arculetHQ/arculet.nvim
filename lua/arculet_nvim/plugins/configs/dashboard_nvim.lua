local M = {}

local function arculet_header()
    return {
    	"",
    	"  █████╗ ██████╗  ██████╗██╗   ██╗██╗     ███████╗████████╗ ",
	    " ██╔══██╗██╔══██╗██╔════╝██║   ██║██║     ██╔════╝╚══██╔══╝ ",
	    " ███████║██████╔╝██║     ██║   ██║██║     █████╗     ██║    ",
	    " ██╔══██║██╔══██╗██║     ██║   ██║██║     ██╔══╝     ██║    ",
	    " ██║  ██║██║  ██║╚██████╗╚██████╔╝███████╗███████╗   ██║    ",
	    " ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝   ╚═╝    ",
	    "                                                     .nvim  ",
        ""
    } 
end

local function arculet_footer()
    -- Requires packages: curl
    local quotesAPIEP = "https://qapi.vercel.app/api/random"
    local response = vim.fn.system("curl -s " .. quotesAPIEP)
    local success, json = pcall(vim.fn.json_decode, response)

    if success then
        return {
	    "",
	    json.quote,
	    "- " .. json.author
    	}
    else
	-- Fallback
    return {
	    "",
	    "Do not wait to strike till the iron is hot; but make it hot by striking.",
	    "- William Butler Yeats"
	}
    end
end

function M.setup()
    require('dashboard').setup({
    	config = {
	    header = arculet_header(),
	    shortcut = {
    		{
		    desc = "[ Arculet Studios]",
		    group = "DashboardShortCut"
	        },
		-- {
		--     desc = "[  mrasadatik]",
		--     group = "DashboardShortCut"
	        -- },
		{
		    desc = "[󰊤 v1.0.0]",
		    group = 'DashboardShortCut',
		    key = '<leader>gh',
		    action = ':OpenBrowser https://github.com/arculetHQ/arculet.nvim.git'
	        },
  	    },
	    footer = arculet_footer(),
	}
    })

    vim.keymap.set("n", "<C-d>", "<cmd>Dashboard<CR>", {desc = "Go to dashboard"})
end

return M
