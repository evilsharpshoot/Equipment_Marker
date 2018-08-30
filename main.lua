eventSet = false
icons = {}
spot = {}

hooksecurefunc("ContainerFrame_Update",function(self)
	Mark(self)
end)

local frame = CreateFrame("Frame")
frame:RegisterEvent("EQUIPMENT_SETS_CHANGED")
frame:SetScript("OnEvent", function(self, event, ...)
	CloseAllBags() 
	OpenAllBags()
end)

function Mark(self)
	getMarked(self)
	for i=1,self.size do
		button=_G[self:GetName().."Item"..i]
		slotID = button:GetID()
		bagID = self:GetID()
		if spot[bagID][slotID] then
			if button then
			  button:SetHighlightTexture(icons[bagID][slotID])
			  button.IconBorder:SetVertexColor(1,0,0)
			end
		else
			button:SetHighlightTexture('Interface\\Buttons\\ButtonHilight-Square')
		end
	end
end

function getMarked()
	icons = {}
	spot = {}
	count = C_EquipmentSet.GetNumEquipmentSets();
	
	for x=0,33 do
		spot[x] = {}
		icons[x] = {}
	end
	
	for i = 0,count-1,1 do
		name, texture = C_EquipmentSet.GetEquipmentSetInfo(i)
		equipmentSetID = C_EquipmentSet.GetEquipmentSetID(name);
		gear_locations = C_EquipmentSet.GetItemLocations(equipmentSetID);
		itemIDs = C_EquipmentSet.GetItemIDs(i)
	
		for _, location in pairs(gear_locations) do
			if(type(location) ~= "string") then
				_, _, bags, _, slotIndex, bagIndex = EquipmentManager_UnpackLocation(location);
				if(bags and (slotIndex and bagIndex)) then
					spot[bagIndex][slotIndex] = true
					icons[bagIndex][slotIndex] = texture;
				end
			end
		end
	end
end
