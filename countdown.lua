
PROPERTIES = {year=0, month=0, day=0, hour=0, min=0, sec=0, fintext=""}

function Initialize()

	RELEASEDATE = {}
	setmetatable(RELEASEDATE, getmetatable(PROPERTIES))
	for k,v in pairs(PROPERTIES) do
		if k ~= fintext then
			RELEASEDATE[k] = v
		end
	end
	RELEASEDATE.isdst = true

	RELEASETEXT = PROPERTIES.fintext or ""

end

function GetTimeLeft()
	local dif = os.time(RELEASEDATE) - os.time()
	local timeleft = {
		[1] = math.floor(dif/60/60/24),	--day
		[2] = math.floor(dif/60/60)%24,	--hour
		[3] = math.floor(dif/60)%60,	--minute
		[4] = math.floor(dif)%60		--second
	}

	local text = {}
	-- Definimos las etiquetas para cada posición
	local labels = {"d", "h", "min", "s"}
	for i=1, #timeleft do
		--if i == 1 then
		--	if timeleft[i] > 0 then
		--		table.insert(text,timeleft[i])
		--	end
		--else
		--	table.insert(text,timeleft[i])
		--end
		-- Forzamos a que todos los elementos (incluyendo los días) 
		-- pasen por el formateador de dos dígitos "%02d"
		local formattedNumber = string.format("%02d", timeleft[i])
		-- table.insert(text, string.format("%02d", timeleft[i]))
		table.insert(text, formattedNumber .. labels[i])
	end

	if dif <= 0 then
		text = RELEASETEXT
	else
		text = table.concat(text," : ")
	end

	return tostring(text)
end

function Update()
end

function GetStringValue()

	return GetTimeLeft()

end