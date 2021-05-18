MakeFingersFriendly = { 
    description = "Makes Fingers forget about being beaten!"
}

fingers_beaten_entry = "q105_fingers_beaten"

function MakeFingersFriendly:new()    
    registerForEvent("onUpdate", function(delta) -- do in update because init is too early (before save file has loaded)
        local quests = Game.GetQuestsSystem()
        if quests:GetFactStr(fingers_beaten_entry) == 1 then
            quests:SetFactStr(fingers_beaten_entry, 0)
            print('Fingers has magically forgotten that you beat him!')
        end
    end)
end

return MakeFingersFriendly:new()