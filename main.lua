eventSet = false
ids = {}
icons = {}

hooksecurefunc("ContainerFrame_Update",function(self)
	if not eventSet then
		getMarked()
		eventSet = true;
	end
	Mark(self)
end)

local frame = CreateFrame("Frame")
frame:RegisterEvent("EQUIPMENT_SETS_CHANGED")
frame:SetScript("OnEvent", function(self, event, ...)getMarked()
CloseAllBags() 
OpenAllBags()
end)

function Mark(self)
	for i=1,self.size do
		button=_G[self:GetName().."Item"..i]
		slot = button:GetID()
		itemId = GetContainerItemLink(self:GetID(), slot)
		id = GetContainerItemID(self:GetID(),slot)
		id = tostring(id)
		
		if ids[id] then
			if button then
			  button:SetHighlightTexture(icons[id])
			  button.IconBorder:SetVertexColor(1,0,0)
			end
		else
			button:SetHighlightTexture('Interface\\Buttons\\ButtonHilight-Square')
		end
	end
end

function getMarked()
	ids = {}
	icons = {}
	count = C_EquipmentSet.GetNumEquipmentSets();
	for i = 0,count-1,1 do
		name, texture = C_EquipmentSet.GetEquipmentSetInfo(i)
		itemIDs = C_EquipmentSet.GetItemIDs(i)
		for i=1, 19 do
		  if itemIDs[i] then
			ids[tostring(itemIDs[i])] = itemIDs[i];
			icons[tostring(itemIDs[i])] = texture;
		  end
		end
	end
end