SurveyKnowledge = SurveyKnowledge or {
  name = "SurveyKnowledge",
  abbreviation = 'SK',
  inventories = {}
}

-- EVENT HANDLING
SurveyKnowledge.Handlers = {}

-- EVENT_PLAYER_ACTIVATED
SurveyKnowledge.Handlers.OnPlayerLoaded = function(eventCode, initial)
  SurveyKnowledge.Utilities:debug("Player Loaded")

  -- Initialize the inventories
  SurveyKnowledge.inventories.Bank = SurveyKnowledge.Utilities:getInventory(BAG_BANK)
  SurveyKnowledge.inventories.Bag = SurveyKnowledge.Utilities:getInventory(BAG_BACKPACK)

  -- Iterate through the inventories and print out the surveys found to chat
  for type, Inventory in pairs(SurveyKnowledge.inventories) do
    SurveyKnowledge.Utilities:message("Survey's in " .. type)
    
    local list = Inventory:getSurveys()
    for _, survey in ipairs(list) do
      SurveyKnowledge.Utilities:message("Profession [" .. survey.profession .. "] Zone [" .. survey.zone .. "]")
    end
  end
end

-- REGISTER EVENTS
EVENT_MANAGER:RegisterForEvent(SurveyKnowledge.name, EVENT_PLAYER_ACTIVATED, SurveyKnowledge.Handlers.OnPlayerLoaded)