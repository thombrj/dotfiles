vim.g.mapleader = " "

local map = vim.keymap.set

map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

map("n", "<leader>ee", ":Ex<CR>")
map("n", "<A-n>", ":Ex<CR>")
-- Editing keybinds
map("n", "<leader><C-a>", "maggVG", { desc = "Select all, mark register a" })
map("n", "<leader>yy", "<cmd>%+y<CR>", { desc = "Yank all" })
map("n", "<leader>dd", "<cmd>%+dd<CR>", { desc = "Delete all" })

map("n", "<leader>s", ":e #<CR>", { desc = "Previous buffer" })

map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

map("n", "<leader>+", "<C-a>", { desc = "Increment number" })
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save" })
map("n", "<leader><TAB>", "<C-w>w", { desc = "Tab to new window" })
map({ 'n', 'i' }, "<F1>", "<ESC>")
map("n", "q:", "<ESC>")

map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

map("n", "<leader>rc", ":e ~/.config/nivm/init.lua<CR>", { desc = "Edit nvim config" })

map("n", "<leader>l", ":Lazy<CR>", { desc = "Open Lazy" })
map({ "n", "v" }, "<leader>d", '"_d"', { desc = "Delete without yanking" })

map("n", "<A-S-f>", "<CMD>lua vim.lsp.buf.format()<CR>", { desc = "Format the current buffer with lsp" })
