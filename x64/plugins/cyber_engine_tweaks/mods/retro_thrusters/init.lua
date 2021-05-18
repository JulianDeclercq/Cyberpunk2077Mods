RetroThrusters = { 
    description = "Non quest-bound retrothrusters!"
}

removable = false

function RetroThrusters:new()

	registerForEvent("onInit", function(delta)
		local isLoaded = Game.GetPlayer() and Game.GetPlayer():IsAttached() and not GetSingleton('inkMenuScenario'):GetSystemRequestsHandler():IsPreGame()
		Observe('QuestTrackerGameController', 'OnInitialize', function()
		    if not isLoaded then
		        print('Game Session Started')
		        isLoaded = true

		        -- TODO: If thrusters not equiped / no thrusters in inventory (discord channel cetluascripting: keyword inventory):
		        --Game.AddToInventory("Items.q115_thrusters",1) --inventory seems to have unlimited space so nothing to worry there i think
		        
    	    	--	local es = Game.GetScriptableSystemsContainer():Get(CName.new('EquipmentSystem'))
    	    	--	local activeFeet = es:GetActiveItem(Game.GetPlayer(), 'Feet')
				--	local feetTweakDBID = activeFeet.id
				--	local displayNameTweakDBID = TweakDBID.new(feetTweakDBID, '.displayName')
				--	local displayNameLocKey = Game['TDB::GetLocKey;TweakDBID'](displayNameTweakDBID)
				--	print(Game.GetLocalizedTextByKey(displayNameLocKey))
		    end
		end)
		
		Observe('QuestTrackerGameController', 'OnUninitialize', function()
		    if Game.GetPlayer() == nil then
		        print('Game Session Ended')
		        isLoaded = false
		    end
		end)
	end)

	registerForEvent("onUpdate", function(delta)
		if not removable and isLoaded then
			removable = true
			retrothrustersItemID = GetSingleton('gameItemID'):FromTDBID(TweakDBID.new('Items.q115_thrusters'))
	        print('RetroThrusterss in backpack: ')
	        print(Game.GetTransactionSystem():GetItemQuantity(Game.GetPlayer(), retrothrustersItemID))
			
			local equippedItemID = Game.GetScriptableSystemsContainer():Get('EquipmentSystem'):GetItemInEquipSlot(Game.GetPlayer(), 'Feet', 0)
			if equippedItemID then
				print('feet slot has something equiped')
				local expectedTweakDBID = TweakDBID.new('Items.q115_thrusters')
				if tostring(equippedItemID.id) == tostring(expectedTweakDBID) then
			    	print('Thrusters equiped')
			    	local feetItemData = Game.GetTransactionSystem():GetItemInSlot(Game.GetPlayer(), TweakDBID.new("AttachmentSlots.Feet")):GetItemData()
					feetItemData:RemoveDynamicTag("UnequipBlocked")
					feetItemData:RemoveDynamicTag("Quest")
					print("Can now unequip thrusters")
				end
			end
		end
	end)
end

return RetroThrusters:new()