local m = {}

function m.packageNameToUseFlags(package)
	local commands = {
		["bash-language-server"] = function()
			return "\n#bash-language-server\nnet-libs/nodejs npm\n"
		end,
		["yaml-language-server"] = function()
			return "\n#yaml-language-server\nnet-libs/nodejs npm\n"
		end,
		["clangd"] = function()
			return "\n#clangd\nllvm-core/clang extra"
		end,
		["clang-tidy"] = function()
			return "\n#clang-tidy\nllvm-core/clang extra"
		end,
		default = function()
			return ""
		end,
	}
	local fn = commands[package] or commands.default
	return fn()
end

function m.generateFile(packages)
	local data = ""
	for i = 1, #packages do
		data = data .. m.packageNameToUseFlags(packages[i])
	end
	return data
end

function m.saveFile(contents, filePath)
	local file = io.open(vim.fs.normalize(filePath), "w")
	if file ~= nil then
		file:write(contents)
		file:close()
	end
end

return m
