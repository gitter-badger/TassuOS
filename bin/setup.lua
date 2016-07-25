TassuOS.clear()

program = Bedrock:Initialise()
local textNormal = ""
local textConfirm = ""

program:Run(function()
	program:LoadView("setup")

	program:GetObject('NextButton').OnClick = function(self, event, side, x, y)
		if textNormal == "" then
			program:DisplayAlertWindow("Error", "You need to enter two passwords.", {"Ok"}, function(value)
				if value == "Ok" then
        			if program.Window then --program.Window is the current window, you should also use an if because the user might have closed the window
						program.Window:Close()
					end
				end
			end)
			return nil
		end
		if textNormal == textConfirm then 
			fs.makeDir(".data")
			local h = fs.open(".data/users/root", "w")
			h.write(textNormal)
			h.close()
		else
			program:DisplayAlertWindow("Error", "The passwords does not match.", {"Ok"}, function(value)
				if value == "Ok" then
        			if program.Window then --program.Window is the current window, you should also use an if because the user might have closed the window
						program.Window:Close()
					end
				end
			end)
		end 
	end
	program:GetObject('PasswordTextBox').OnChange = function(self, event, keychar)
		textNormal = self.Text
	end
	program:GetObject('PasswordConfirmTextBox').OnChange = function(self, event, keychar)
		textConfirm = self.Text
	end

end)