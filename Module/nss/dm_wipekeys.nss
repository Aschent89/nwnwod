void main() {
    string sMessage = GetPCChatMessage();
    object oPC = GetPCChatSpeaker();
    if (GetStringLeft(sMessage, 12) == "dm_wipekeys ") {
        if (!GetIsDM(oPC))
            FloatingTextStringOnCreature("Only DMs may use this command!", oPC, FALSE);
        else {
            string sPlayerName = GetStringRight(sMessage, GetStringLength(sMessage)-12);
            string sStoredKey = GetCampaignString("PlayernameKey", sPlayerName);
            if (sStoredKey != "") {
                DeleteCampaignVariable("PlayernameKey", sPlayerName);
                FloatingTextStringOnCreature("CD Key bindings for Playername: '" + sPlayerName + "' erased.", oPC, FALSE);
            } else {
                FloatingTextStringOnCreature("No CD Key bindings for Playername: '" + sPlayerName +
                    "' were found! Please check to make sure you entered the right name.", oPC, FALSE);
            }
        }
    }
}
