--[[
	Installs Moses; a useful extension to the standard offerings from Lua.
	Upon installation it creates a lua directory and moves the appropriate files
	into this directory so it can be required elsewhere.
--]]
return {
	"Yonaba/Moses",
	-- Move into a recognised path
	build = "mkdir lua && mv moses.lua lua/moses.lua"
}
