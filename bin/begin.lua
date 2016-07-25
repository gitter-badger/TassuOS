-- Program functions...

local function centerPrint(text, ny)
	if type(text) == "table" then
		for _,v in pairs(text) do
			centerPrint(v)
		end
	else
		local _,y = term.getCursorPos()
		local w,h = term.getSize()
		term.setCursorPos(math.ceil((w-#text)/2), ny or y)
		print(text)
	end
end

local function main(...)
	term.setBackgroundColor(colors.black)
	term.setTextColor(colors.red)
	term.clear()

	centerPrint("TassuOS", 2)
	centerPrint("-------", 3)
	print("")
	term.setTextColor(colors.white)

	local FileList = fs.list("/lib") --Table with all the files and directories available

	for _, file in ipairs(FileList) do
		os.loadAPI("/lib/"..file)
	end 

	fs.delete("/tmp")
	fs.makeDir("/tmp")

	_G["Bedrock"] = zBedrock

	if not fs.exists("/.data") then
		dofile("/bin/setup.lua")
		error()
	else
		local program = Bedrock:Initialise()

		program:Run(function()
			program:GetObject('VersionLabel').Text = TassuOS.version
			program:GetObject('InfoLabel').Text = "Bugs: http://tinyurl.com/tassu-bugs"

		end)
	end



end

-- Run
local args = {...}
local _, err = pcall(function() main(unpack(args)) end)
if err then
	-- Make a nice error handling screen here...
	term.setBackgroundColor(colors.black)
	term.setTextColor(colors.red)
	term.clear()

	centerPrint("TassuOS ERROR", 2)
	print("---------------------------------------------------")
	print("")
	term.setTextColor(colors.white)
	print(err)
	print(_HOST)


end