local M = {}

-- Keep track of toggle states
local toggle_cache = {}

--- Toggle between two Harpoon items.
-- @param idx1 The first index to toggle.
-- @param idx2 The second index to toggle.
local function harpoon_toggle(harpoon_m, idx1, idx2)
    -- Ensure indices are valid
    local sorted_idx1 = math.min(idx1, idx2)
    local sorted_idx2 = math.max(idx1, idx2)
    local cache_key = string.format("%d-%d", sorted_idx1, sorted_idx2)

    return function()
        local list = harpoon_m:list()

        -- Validate indices are within list bounds
        if sorted_idx2 > #list.items then
            vim.notify(string.format(
                "Harpoon list only has %d items (requested %d and %d)",
                #list.items,
                sorted_idx1,
                sorted_idx2
            ), vim.log.levels.WARN)
            return
        end

        -- Initialize or get current toggle state
        toggle_cache[cache_key] = toggle_cache[cache_key] or sorted_idx1
        local current_index = toggle_cache[cache_key]
        local new_index = current_index == sorted_idx1 and sorted_idx2 or sorted_idx1

        -- Perform the toggle
        list:select(new_index)
        toggle_cache[cache_key] = new_index
    end
end

function M.setup()
    require("harpoon"):setup()
    require("harpoon"):extend(require("harpoon.extensions").builtins.highlight_current_file())
end

function M.keys()    
    return {
        { "n", "<leader>aa", function() require("harpoon"):list():add() end, desc = "Add current buffer to the Harpoon list" },
        { "n", "<C-e>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Toggle Harpoon quick menu" },
        { "n", "<leader><Tab>", harpoon_toggle(require("harpoon"), 1, 2), desc = "Toggle between items 1 and 2" },
        { "n", "<M-i>", function() require("harpoon"):list():prev() end, desc = "Switch to the previous buffer on the Harpoon list" },
        { "n", "<M-o>", function() require("harpoon"):list():next() end, desc = "Switch to the next buffer on the Harpoon list" },
    }
end

return M
