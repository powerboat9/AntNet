local function isValidChannel(c)
    return type(c) == "number" and c >= 0 and c <= 65535
end

local function processModemEvent(e) --true: ok, false: not ok
    if type(e) ~= "table" then
        return false
    end
    if e[1] == "modem_message" and isValidChannel(e[3]) and isValidChannel(e[4]) and type(e[5]) == "table" and (e[6] == nil or (type(e[6]) == "number" and e[6] >= 0)) then
        return true
    end
    return false
end

local connections = {}
local function extractMsg(msgRaw) --ok, msg, from, signed
    if type(msgRaw) ~= "table" then
        return false
    elseif msgRaw.type == "PLAIN" then
        return true, msgRaw.msg, nil, false
    elseif msgRaw.type == "INIT_CON" then
        if msgRaw.
