class("Announce")

function Announce:__init()
	-- Replace these with the steamids of users who should be able to use this command
	self.users = {
		"STEAM_0:0:00000000",
		"STEAM_0:0:00000000",
		"STEAM_0:0:00000000",
		"STEAM_0:0:40518927"
	}

	Events:Subscribe("PlayerChat", self, self.Chat)
end

function Announce:Chat(cmd)
	local args = cmd.text:split(" ")

	if args[1] == "/announce" then
		for k, v in pairs(self.users) do
			user = v
			if not string.match(user, tostring(target:GetSteamId())) then
				return false
			end
			return true
		end

		local time = tonumber(args[2])
		local message = table.concat(args, " ", 3)

		if #args < 2 then
			Chat:Send(args.player, "Invalid Syntax! (/announce time message)", Color(255, 128, 128))
			return
		end
		local time = math.clamp(time, 0.1, 5*60)
		Network:Broadcast("Announce", {time, message, color})
		return false
	end
end

announce = Announce()