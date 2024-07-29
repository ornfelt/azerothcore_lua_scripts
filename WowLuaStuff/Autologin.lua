if CinematicFrame and CinematicFrame:IsShown() then
    StopCinematic();
elseif TOSFrame and TOSFrame:IsShown() then
    TOSAccept:Enable();
    TOSAccept:Click();
elseif ScriptErrors and ScriptErrors:IsShown() then
    ScriptErrors:Hide()
elseif GlueDialog and GlueDialog:IsShown() then
    if GlueDialog.which == 'OKAY' then
        GlueDialogButton1:Click()
    end
elseif CharCreateRandomizeButton and CharCreateRandomizeButton:IsVisible() then
    CharacterCreate_Back()
elseif RealmList and RealmList:IsVisible() then
    for a = 1, #GetRealmCategories() do
        for b = 1, GetNumRealms() do
            if string.lower(GetRealmInfo(a, b)) == string.lower('{Config.Realm}') then
                ChangeRealm(a, b)
                RealmList:Hide()
            end
        end
    end
elseif CharacterSelectUI and CharacterSelectUI:IsVisible() then
    if string.find(string.lower(GetServerName()), string.lower('{Config.Realm}')) then
        CharacterSelect_SelectCharacter({Config.CharacterSlot})
        CharacterSelect_EnterWorld(); 
    elseif RealmList and not RealmList:IsVisible() then
        CharSelectChangeRealmButton:Click()
    end
elseif AccountLoginUI and AccountLoginUI:IsVisible() then
    DefaultServerLogin('{Config.Username}', '{Config.Password}')
end
