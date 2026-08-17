-- Lazy.nvim を自動ダウンロードするコード
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- 「lua/plugins フォルダの中身を全部読み込め」という指定
require("lazy").setup({
	spec = {
		{ import = "plugins.git" },
		{ import = "plugins.scope" },
		{ import = "plugins.ui" },
		{ import = "plugins.utility" },
		{ import = "plugins.terminal" },
		{ import = "plugins.theme" },
		{ import = "plugins.lsp" },
	},
})
