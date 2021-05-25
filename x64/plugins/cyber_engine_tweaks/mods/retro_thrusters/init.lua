RetroThrusters = { 
    description = "Non quest-bound retrothrusters!"
}

_isLoaded = false

function RetroThrusters:new()

	registerForEvent("onInit", function(delta)
		_isLoaded = Game.GetPlayer() and Game.GetPlayer():IsAttached() and not GetSingleton('inkMenuScenario'):GetSystemRequestsHandler():IsPreGame()
		Observe('QuestTrackerGameController', 'OnInitialize', function()
		    if not _isLoaded then
		        print('Game Session Started')
		        _isLoaded = true

		    	-- check if player already owns thrusters
		    	thrusters = 'Items.q115_thrusters'
    			local thrustersTDBID = TweakDBID.new(thrusters)
    			local itemFound = false
	
				-- check inventory (worn slot is included in GetItemList)  		
    			local success, items = Game.GetTransactionSystem():GetItemList(Game.GetPlayer())
			    for _, itemData in ipairs(items) do
			        if tostring(itemData:GetID().id) == tostring(thrustersTDBID) then
			            itemFound = true
			            print('Player already owns removable RetroThrusters!')
			            break
			        end
			    end
	
    			-- add the item to the inventory if player didn't own thrusters
    			if not itemFound then
    				-- add RetroThrusters to inventory
    			    Game.AddToInventory(thrusters, 1)

    			   	-- make added RetroThrusters unequipable
    			    local success, items = Game.GetTransactionSystem():GetItemList(Game.GetPlayer())
			    	for _, itemData in ipairs(items) do
			    	    if tostring(itemData:GetID().id) == tostring(thrustersTDBID) then
			    	        itemData:RemoveDynamicTag("UnequipBlocked")
							itemData:RemoveDynamicTag("Quest")
			    	        print('Added removable RetroThrusters to inventory!')
			    	        break
			    	    end
			    	end
    			end
		    end
		end)
		
		Observe('QuestTrackerGameController', 'OnUninitialize', function()
		    if Game.GetPlayer() == nil then
		        print('Game Session Ended')
		        _isLoaded = false
		    end
		end)
	end)
end

return RetroThrusters:new()