int VerifyPlayernameAgainstCDKey(object oPlayer) {
    int nBoot = FALSE;
    string sPName = GetPCPlayerName(oPlayer);
    string sKey = GetPCPublicCDKey(oPlayer);

    string sNewKey, sAddingKey, sStoredKey = GetCampaignString("PlayernameKey", sPName);

    /* there's at least one key stored already */

    if (sStoredKey != "") {
        sAddingKey = GetStringLeft(sStoredKey, 3);
        sStoredKey = GetStringRight(sStoredKey, GetStringLength(sStoredKey) - 3);

        /* they indicated that they wanted to add a key this login */

        if (sAddingKey == "ADD") {

            /* their current key is not in the key string, add it unless at 7 keys already */
            if (FindSubString(sStoredKey, sKey) == -1) {
                int nKeyLength = GetStringLength(sStoredKey);
       // Line changed from if (nLength > 65) // To not allow 7 keys for people but 3. Instead as of 1-19-2012
                /* allow 7 keys max SET-key-key-key-key-key-key-key   SET/ADD + 7 spacers + 7x8 keys = 66 */
                if (nKeyLength > 29) {
                    nBoot = TRUE;

                    /* must mark as no longer adding */
                    SetCampaignString("PlayernameKey", sPName, "SET" + sStoredKey);

                    /* add the key to the string */
                } else {
                    sNewKey = "SET" + sStoredKey  + "-" + sKey;
                    SetCampaignString("PlayernameKey", sPName, sNewKey);
                    DelayCommand(25.0, FloatingTextStringOnCreature("New CD Key Successfully Added!", oPlayer, FALSE));
                }

                /* let them know they already had this key in their string */
            } else {
                DelayCommand(25.0,
                    FloatingTextStringOnCreature("CD Key Addition Failed! This key already listed for this account!", oPlayer,
                        FALSE));

                /* must mark as no longer adding */
                SetCampaignString("PlayernameKey", sPName, "SET" + sStoredKey);
            }


            /* they are not adding, and the cd key doesnt match those listed - boot and log */
        } else if (FindSubString(sStoredKey, sKey) == -1) {
            string sReport = "INCORRECT CD KEY DETECTED! ID: " + sPName + "; Name: " +
                GetName(oPlayer) + "; CD Key: " + sKey + "; IP: " + GetPCIPAddress(oPlayer);

            WriteTimestampedLogEntry(sReport);
            SendMessageToAllDMs(sReport);

            nBoot = TRUE;
        }


        /* new account, add the key */
    } else {
        SetCampaignString("PlayernameKey", sPName, "SET-" + sKey);
    }

    return nBoot;
}
void main() {

    object oPC = GetEnteringObject();

    /* verify CD keys and double logins to stop hackers */
    if (VerifyPlayernameAgainstCDKey(oPC)) {
        if (GetIsObjectValid(oPC))
            BootPC(oPC);
        return;
    }
}

