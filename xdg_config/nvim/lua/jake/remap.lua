-- TODO: make this pretty
local make_map = require("jake.utils").make_map

local nmap = make_map("n", {})
local vmap = make_map("v", {})
vmap("J", ":m '>+1<CR>gv=gv", "Slide selection down")
vmap("K", ":m '<-2<CR>gv=gv", "Slide selection up")
vmap("<", "<gv", "Slide selection left one indent")
vmap(">", ">gv", "Slide selection right one indent")

nmap("<C-u>", "<C-u>zz", "[u]p half page and center screen")
nmap("<C-d>", "<C-d>zz", "[d]own half page and center screen")
nmap("G", "Gzz", "[G]o all the way down and center screen")

nmap("[q", function() vim.cmd.cNext() end, "Previous [q]fix list item")
nmap("]q", function() vim.cmd.cnext() end, "Next [q]fix list item")

nmap("<C-Q>", function() vim.cmd.copen() end, "Toggle [q]fix list")

