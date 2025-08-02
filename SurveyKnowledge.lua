SurveyKnowledge = SurveyKnowledge or {
  name = "SurveyKnowledge",
  abbreviation = 'SK'
}

-- UTILITIES
SurveyKnowledge.Utilities = {}

SurveyKnowledge.Utilities.debug = function(self, msg)
  d("[SurveyKnowledge] " .. msg)
end

SurveyKnowledge.Utilities.message = function(self, msg)
  if not self.chat then
    self.chat = LibChatMessage(SurveyKnowledge.name, SurveyKnowledge.abbreviation)
  end
  self.chat:SetTagColor("A974E3"):Print(string.format("|cA974E3%s|r ",msg))
end

-- EVENT HANDLING
SurveyKnowledge.Handlers = {}

-- EVENT_PLAYER_ACTIVATED
SurveyKnowledge.Handlers.OnPlayerLoaded = function(eventCode, initial)
  SurveyKnowledge.Utilities:debug("Player Loaded")
end

-- REGISTER EVENTS
EVENT_MANAGER:RegisterForEvent(SurveyKnowledge.name, EVENT_PLAYER_ACTIVATED, SurveyKnowledge.Handlers.OnPlayerLoaded)