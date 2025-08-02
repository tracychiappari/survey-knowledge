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