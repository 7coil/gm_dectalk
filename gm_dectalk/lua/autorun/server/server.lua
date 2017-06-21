util.AddNetworkString('dectalk')

function senddectalk(talk)
	net.Start('dectalk')
	net.WriteString(talk)
	net.Broadcast()
end

hook.Add( "PlayerSay", "dectalk", function( ply, text, team )
	if !ply.cooldown or ply:IsAdmin() then
		senddectalk(text)

		-- Set the cooldown flag
		ply.cooldown = true

		-- Disable the cooldown after 5 seconds
		timer.Simple(5, function()
			ply.cooldown = false
		end )
	end
end
)
