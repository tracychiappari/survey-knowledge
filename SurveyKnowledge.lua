SurveyKnowledge = SurveyKnowledge or {
    name = "SurveyKnowledge",
    abbreviation = 'SK',
    inventories = {}
}

-- EVENT HANDLING
SurveyKnowledge.Handlers = {}

-- EVENT_PLAYER_ACTIVATED
SurveyKnowledge.Handlers.OnPlayerLoaded = function(eventCode, initial)
    SK_Utilities:debug("Player Loaded")

    SurveyKnowledgePanel:SetHidden(false)

    SurveyKnowledge.inventories.Bank = SK_Utilities:getInventory(BAG_BANK)
    SurveyKnowledge.inventories.Bag = SK_Utilities:getInventory(BAG_BACKPACK)

    local initialList = {}

    for type, Inventory in pairs(SurveyKnowledge.inventories) do
        SK_Utilities:message("Survey's in " .. type)

        local list = Inventory:getSurveys()
        for _, survey in ipairs(list) do
            SK_Utilities:message("Profession [" .. survey.profession .. "] Zone [" .. survey.zone .. "]")
            table.insert(initialList, {
                inventory = type,
                profession = survey.profession,
                zone = survey.zone
            })
        end
    end

    SurveyKnowledge.list = SK_SortFilterList:New(SurveyKnowledgePanelMainContainer, initialList)
end

-- REGISTER EVENTS
-- TODO: Figure out why EVENT_ADD_ON_LOADED doesn't seem to be firing
EVENT_MANAGER:RegisterForEvent(SurveyKnowledge.name, EVENT_PLAYER_ACTIVATED, SurveyKnowledge.Handlers.OnPlayerLoaded)
