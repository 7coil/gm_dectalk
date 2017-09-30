g_station = nil;

--Recieve ChatTaunts
net.Receive( "dectalk", function()
	if ("0" == file.Read("tts.txt", "DATA")) then
		return print("[DECtalk] Blocked DECtalk. To enable, type `tts_enable`")
	end

	local text = net.ReadString()

	sound.PlayURL(text, "", function(station, id, msg)
		if ( IsValid( station ) ) then
			station:Play()
			-- Don't allow the Trash Compactor to clear out station just yet, fixes cutting out.
			g_station = station
		else
			print("[DECtalk] Could not request " .. text .. ".")
		end
	end )

end )

concommand.Add( "tts_disable", function()
	file.Write("tts.txt", "0")
end )

concommand.Add( "tts_enable", function()
	file.Write("tts.txt", "1")
end )


