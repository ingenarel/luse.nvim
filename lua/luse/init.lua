local m

function m.packageNameToUseFlags(package)
	local commands = {
		["bash-language-server"] = function()
			return "\nnet-libs/nodejs npm\n"
		end,
		default = function()
			return ""
		end,
	}
	commands["yaml-language-server"] = commands["bash-language-server"]
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

return m
