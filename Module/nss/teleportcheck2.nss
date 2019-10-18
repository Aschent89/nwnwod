int StartingConditional()
{
    object oPC = GetLastSpeaker();
    string sTag1 = GetName( oPC ) + "_" + GetPCPublicCDKey(oPC);
    string sTag2 = "Int_binding_2";

    if(GetCampaignInt(sTag1, sTag2, oPC) !=1)
        return FALSE;

    return TRUE;
}
