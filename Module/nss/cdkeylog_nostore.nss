int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sStoredKey = GetCampaignString("PlayernameKey", GetPCPlayerName(oPC));
    if (sStoredKey != "") {
        int nLength =  GetStringLength(sStoredKey);
           // Line changed from if (nLength > 65) // To not allow 7 keys for people but 3. Instead as of 1-19-2012
        if (nLength > 29) /* allow 7 keys max SET-key-key-key-key-key-key-key   SET/ADD + 7 spacers + 7x8 keys = 66 */
            return FALSE;
    }
    return TRUE;
}
