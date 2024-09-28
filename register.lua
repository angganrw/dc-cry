


--[[
RegisterCommand("radio",function()
    radio()  
end)
]]--

RegisterCommand("document",function()
    document()  
end)


--RegisterKeyMapping("fixinven", "Membuka Tas", "keyboard", 'this.Configuration.ToggleRange')
--RegisterKeyMapping("radio", "Membuka Radio", "keyboard", 'this.Configuration.TalkSecondary')
RegisterKeyMapping("document", "Membuka Document", "keyboard", 'this.Configuration.TalkPrimary')
--RegisterKeyMapping("closemenu", "Stuck Menu F1", "keyboard", 'this.Configuration.TalkPrimary')
