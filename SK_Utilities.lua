-- UTILITIES
SK_Utilities = {}

SK_Utilities.debug = function(self, msg)
    d("[SurveyKnowledge] " .. msg)
end

SK_Utilities.message = function(self, msg)
    if not self.chat then
        self.chat = LibChatMessage(SurveyKnowledge.name, SurveyKnowledge.abbreviation)
    end
    self.chat:SetTagColor("A974E3"):Print(string.format("|cA974E3%s|r ", msg))
end

SK_Utilities.ucwords = function(self, str)
    -- Borrowing name from PHP's ucwords function, this will capitalize the first letter of each word in a string
    -- This is a useful utility, but Lua does not have a built-in function for this.
    -- The pattern used here is:
    --  (%a) One alphabetic character
    --  (%w*) One or more alphanumeric character(s)
    -- gsub as a global pattern should send each space seperated word to the replace function independently.
    return str:gsub("(%a)([%w']*)", function(first, rest)
        return first:upper() .. rest:lower()
    end)
end

SK_Utilities.format = function(self, str)
  -- This function will format the string to be in a more readable format, capitalizing the first letter of each word.
  -- zo_strformat: Formats strings with interpolation, pluralization, localization and many other features.
  return self:ucwords(zo_strformat("<<1>>", str):lower())
end

SK_Utilities.parseSurveyName = function(self, surveyName)
    -- The expected format is "Profession Survey: Zone Name"
    local profession, zone = surveyName:match("^(.-) Survey:%s*(.+)$")
    return profession, zone
end

-- Constructor function for inventory
SK_Utilities.getInventory = function(Utilities, type)
    local inventory = {}

    inventory.getName = function(self, slot)
        return GetItemName(type, slot)
    end

    inventory.getSurveys = function(self)
        local surveys = {}

        local slot = ZO_GetNextBagSlotIndex(type)
        while slot do
            local name = Utilities:format(self:getName(slot))
            if name:find("Survey") ~= nil then
                local profession, zone = Utilities:parseSurveyName(name)
                table.insert(surveys, {
                    index = type * slot,
                    profession = profession,
                    zone = zone
                })
            end
            slot = ZO_GetNextBagSlotIndex(type, slot)
        end

        return surveys
    end

    return inventory
end
