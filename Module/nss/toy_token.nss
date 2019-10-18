int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sItemName = GetLocalString(oPC, "MR_TOY_NAME");
    object oOwner = GetLocalObject(oPC, "MR_TOY_OWNER");
    string sName = GetName(oOwner);
    SetCustomToken(3369, sName);
    SetCustomToken(3370, sItemName);

    return TRUE;
}
