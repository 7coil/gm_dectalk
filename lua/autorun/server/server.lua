url = 'http://talk.moustacheminer.com'

util.AddNetworkString('dectalk')

hook.Add( 'PlayerSay', 'dectalk', function( ply, text, teamchat )
	net.Start('dectalk')
	net.WriteString(url .. "/api/gen/?dectalk=" .. url_encode(text))

	if teamchat then
		net.Send(team.GetPlayers(ply:Team()))
	else
		net.Broadcast()
	end
end
)

concommand.Add( 'tts_url', function(ply, cmd, args, argStr)
	url = argStr
end )

function url_encode(str)
	if (str) then
		str = string.gsub (str, "\n", "\r\n")
		str = string.gsub (str, "([^%w %-%_%.%~])",
		function (c) return string.format ("%%%02X", string.byte(c)) end)
		str = string.gsub (str, " ", "+")
	end
	return str
end
