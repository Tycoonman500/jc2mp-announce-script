class("Announce")

function Announce:__init()
	self.announcements = {}

	Events:Subscribe("Render", self, self.Render)
	Network:Subscribe("Announce", self, self.Network)
end

function Announce:Render()
	for k,v in pairs(self.announcements) do
		if v.timer:GetSeconds() >= v.time then
			table.remove(self.announcements, k)
		else
			local w = Render.Width
			local h = Render.Width
			local text_w = Render:GetTextWidth(v.message, TextSize.Large)
			local text_h = Render:GetTextHeight(v.message, TextSize.Large)

			local yoffset = (k - 1) * (Render:GetTextHeight(v.message, TextSize.Large) + 10)

			Render:DrawText(Vector2((w - text_w)/2, 50 + yoffset), v.message, Color(255, 0 ,0), TextSize.Large)
		end
	end
end

function Announce:Network(args)
	local announcement = {
		['time'] = args[1],
		['message'] = args[2],
		['timer'] = Timer(),
	}
	table.insert(self.announcements, announcement)
end

announce = Announce()