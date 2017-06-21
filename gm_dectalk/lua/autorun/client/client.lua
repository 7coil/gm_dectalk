g_station = nil;

--Recieve ChatTaunts
net.Receive( "dectalk", function()
	print("[DECtalk] Data recieved!")
	local text = url_encode(net.ReadString())
	--local text = net.ReadString()
	local disk = net.ReadBool()
	if ("0" == file.Read("tts.txt", "DATA")) then
		return print("[DECtalk] Blocked DECtalk. To enable, type `tts_enable`")
	end

	print("http://talk.moustacheminer.com/api/gen/?dectalk=" .. text)
	sound.PlayURL("http://talk.moustacheminer.com/api/gen/?dectalk=" .. text, "", function(station, id, msg)
		print(id)
		print(msg)
		if ( IsValid( station ) ) then
			station:Play()
			g_station = station
		else
			LocalPlayer():ChatPrint("Invalid URL!")
		end
	end )

end )

concommand.Add( "tts_disable", function()
	file.Write("tts.txt", "0")
end )

concommand.Add( "tts_enable", function()
	file.Write("tts.txt", "1")
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
