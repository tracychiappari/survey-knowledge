SurveyKnowledge = SurveyKnowledge or {
  name = "SurveyKnowledge",
  abbreviation = 'SK'
}

-- EVENT HANDLING
SurveyKnowledge.Handlers = {}

-- EVENT_PLAYER_ACTIVATED
SurveyKnowledge.Handlers.OnPlayerLoaded = function(eventCode, initial)
  SurveyKnowledge.Utilities:debug("Player Loaded")
end

-- REGISTER EVENTS
EVENT_MANAGER:RegisterForEvent(SurveyKnowledge.name, EVENT_PLAYER_ACTIVATED, SurveyKnowledge.Handlers.OnPlayerLoaded)