local map = vim.keymap.set

-- Yank
map("x", "<Leader>y", '"+y')
map("n", "<Leader>yF", "<Cmd>let @+ = expand('%:p:~')<CR>")
map("n", "<Leader>yf", "<Cmd>let @+ = expand('%')<CR>")

-- Files
map("n", "-", "<Cmd>Oil<CR>")
map("n", "_", "<Cmd>Oil .<CR>")

-- Buffers
map("n", "<Leader>bd", function()
    require("mini.bufremove").delete()
end)

-- Git
map("n", "<Leader>gs", "<Cmd>Git<CR>")
map("n", "<Leader>gd", "<Cmd>Git diff<CR>")
map("n", "<Leader>gD", "<Cmd>Git diff --staged<CR>")
map("n", "<Leader>go", function()
    require("mini.diff").toggle_overlay()
end)
map("n", "<Leader>gb", "<Cmd>Git blame<CR>")
map("n", "<Leader>gl", "<Cmd>Git log<CR>")
map("n", "<Leader>ghb", "<Cmd>silent !gh browse %<CR>")
map("n", "<Leader>ghr", "<Cmd>silent !gh repo view --web<CR>")

-- Search and replace)
map("n", "<leader>f", ":Telescope find_files<CR>", { desc = "Find Files (Fuzzy Search)" })
map("n", "<Leader>fl", ":Telescope live_grep<CR>", { desc = "grep within files (Fuzzy Search)" })
map("n", "<Leader>sr", function()
    require("grug-far").open({
        prefills = {
            paths = vim.fn.expand("%"),
        },
    })
end)
map("n", "<Leader>sR", function()
    require("grug-far").grug_far({})
end)
map("n", "<C-n>", ":Neotree toggle<CR>", { desc = "Toggle File Explorer" })

map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
map("n", "<Leader>do", vim.diagnostic.open_float, { noremap = true, silent = true })

map("n", "<Leader>fd", ":Lspsaga finder def<CR>", { desc = "Find definition" })
map("n", "<Leader>fi", ":Lspsaga finder def+imp<CR>", { desc = "Find implementation" })
