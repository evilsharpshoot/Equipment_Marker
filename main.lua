hooksecurefunc("ContainerFrame_Update",function(self)
  for i=1,self.size do
    
	local button=_G[self:GetName().."Item"..i]
    local slot = button:GetID()
	
	itemId = GetContainerItemLink(self:GetID(), slot)
	
	ids ,icons = getMarked();
	
	id = GetContainerItemID(self:GetID(),slot)
	id = tostring(id)

	if ids[id] then
		if button then
		  button:SetHighlightTexture(icons[id])
		  button.IconBorder:SetVertexColor(1,0,0)
		end
	end
	
  end
end)

function getMarked()
	mark = {}
	icon = {} 
	count = C_EquipmentSet.GetNumEquipmentSets();
	for i = 0,count-1,1 do
		name, texture  = C_EquipmentSet.GetEquipmentSetInfo(i)
		local itemIDs = C_EquipmentSet.GetItemIDs(i)
		for i=1, 19 do
		  if itemIDs[i] then
			mark[tostring(itemIDs[i])] = itemIDs[i];
			icon[tostring(itemIDs[i])] = texture;
		  end
		end
	end
	return mark, icon;
end