return function(M)
	local PMs = {"efm", "efm???", "ne?", "ne var"}
	local PS = game:GetService("Players")
	local LC = 0
	local MI = {}

	local function FP(P)
		local C = P.Character
		if not C or not C.PrimaryPart then return nil end

		local R = C.PrimaryPart
		local LV = R.CFrame.LookVector
		local FP = R.Position + (LV * 4)

		local NCF = CFrame.new(FP, R.Position)
		return NCF
	end

	local function x(P)
		if P == PS.LocalPlayer then return end
		P.Chatted:Connect(function(M2)
			if M2:lower() == M then
				if tick() - LC < 10 then return end
				LC = tick()
				local TCF = FP(P)
				if TCF then PS.LocalPlayer.Character:SetPrimaryPartCFrame(TCF)end
				local UD = P.UserId
				if not MI[UD] then MI[UD] = 1;end
				local PM = PMs[MI[UD]]MI[UD] = MI[UD] % #PMs + 1
				task.delay(30, function()MI[UD] = 1;end)
				if game.TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService then
					game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(PM, "All")
				elseif game.TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
					game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(PM)
				end
			end
		end)
	end

	PS.PlayerAdded:Connect(x)
	for _, P in pairs(PS:GetPlayers()) do
		x(P)
	end
end
