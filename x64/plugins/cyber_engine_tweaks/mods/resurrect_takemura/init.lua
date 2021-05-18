ResurrectTakemura = { 
    description = "Resurrect Takemura!"
}

takemura_dead_entry = "q112_takemura_dead"

function ResurrectTakemura:new()    
    registerForEvent("onUpdate", function(delta) -- do in update because init is too early (before save file has loaded)
        local quests = Game.GetQuestsSystem()
        if quests:GetFactStr(takemura_dead_entry) == 1 then
            quests:SetFactStr(takemura_dead_entry, 0)
            print('Takemura has magically returned from the dead!')
        end
    end)
end

return ResurrectTakemura:new()