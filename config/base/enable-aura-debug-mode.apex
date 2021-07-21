// Enable Debug Mode for Lightning Components
User me = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
me.UserPreferencesUserDebugModePref = true;
update me;
