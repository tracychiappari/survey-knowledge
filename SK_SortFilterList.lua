-- =========================================================
-- Subclass of ZO_SortFilterList
-- =========================================================

SK_SortFilterList = ZO_SortFilterList:Subclass()

function SK_SortFilterList:Initialize(control, initialList, ...)
    -- Call parent init
    ZO_SortFilterList.Initialize(self, control, ...)

    self.masterList = initialList

    -- Define sort keys
    self.sortKeys = {
        ["profession"]  = { caseInsensitive = true },
        ["zone"] = { caseInsensitive = true }
    }

    -- OPTIONAL: hook up sort headers if you have them in XML
    self.sortHeaderGroup = ZO_SortHeaderGroup:New(control:GetNamedChild("Headers"), true)
    self.sortHeaderGroup:RegisterCallback(ZO_SortHeaderGroup.ON_SORT_HEADER_SELECTED, function(key, order)
        self.currentSortKey = key
        self.currentSortOrder = order
        self:RefreshData()
    end)

    -- Default sort
    self.currentSortKey = "profession"
    self.currentSortOrder = ZO_SORT_ORDER_UP

    -- AddDataType
    ZO_ScrollList_AddDataType(
        control:GetNamedChild("List"),
        1,
        "SKRowTemplate",
        30,
        function(control, data)
            control:GetNamedChild("Profession"):SetText(data.profession)
            control:GetNamedChild("Zone"):SetText(data.zone)
        end
    )

    -- Build & show list
    self:RefreshData()
end

-- Build the "master" list — all data before filtering
function SK_SortFilterList:BuildMasterList()
    -- self.masterList = {
    --     { name = "Sword",  value = 100 },
    --     { name = "Shield", value = 50 },
    --     { name = "Potion", value = 10 },
    --     { name = "Bow",    value = 75 },
    -- }
end

-- Filter the master list into the scroll list
function SK_SortFilterList:FilterScrollList()
    local scrollData = ZO_ScrollList_GetDataList(self.list)
    ZO_ClearNumericallyIndexedTable(scrollData)

    for _, data in ipairs(self.masterList) do
        if self:PassesFilter(data) then
            table.insert(scrollData, ZO_ScrollList_CreateDataEntry(1, data))
        end
    end
end

-- Example filter: allow everything
function SK_SortFilterList:PassesFilter(data)
    return true
end

-- Sort the filtered list
function SK_SortFilterList:SortScrollList()
    if self.currentSortKey and self.sortKeys[self.currentSortKey] then
        table.sort(ZO_ScrollList_GetDataList(self.list), function(entry1, entry2)
            return ZO_TableOrderingFunction(
                entry1.data,
                entry2.data,
                self.currentSortKey,
                self.sortKeys,
                self.currentSortOrder
            )
        end)
    end
end

-- =========================================================
-- Example XML Layout (Minimal)
-- =========================================================
--[[
<GuiXml>
    <Controls>
        <TopLevelControl name="SKListControl" movable="true" mouseEnabled="true">
            <Dimensions x="300" y="200" />
            <Anchor point="CENTER" />
            <Controls>
                <Control name="$(parent)Headers" inherits="ZO_SortHeaderGroup">
                    <Anchor point="TOPLEFT" />
                    <Anchor point="TOPRIGHT" />
                    <Dimensions y="30" />
                    <Controls>
                        <Control name="$(parent)Name" inherits="ZO_SortHeader">
                            <Dimensions x="150" y="30" />
                            <Anchor point="LEFT" />
                            <OnInitialized>
                                ZO_SortHeader_Initialize(self, "Name", "name", ZO_SORT_ORDER_UP, TEXT_ALIGN_LEFT, "ZoFontHeader")
                            </OnInitialized>
                        </Control>
                        <Control name="$(parent)Value" inherits="ZO_SortHeader">
                            <Dimensions x="150" y="30" />
                            <Anchor point="LEFT" relativeTo="$(parent)Name" relativePoint="RIGHT" />
                            <OnInitialized>
                                ZO_SortHeader_Initialize(self, "Value", "value", ZO_SORT_ORDER_UP, TEXT_ALIGN_LEFT, "ZoFontHeader")
                            </OnInitialized>
                        </Control>
                    </Controls>
                </Control>
                <Control name="$(parent)List" inherits="ZO_ScrollList">
                    <Anchor point="TOPLEFT" relativeTo="$(parent)Headers" relativePoint="BOTTOMLEFT" />
                    <Anchor point="BOTTOMRIGHT" />
                </Control>
            </Controls>
        </TopLevelControl>
    </Controls>
</GuiXml>
]]