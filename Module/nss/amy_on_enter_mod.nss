void main()
{
object oPC = GetEnteringObject();
object oCDTOKEN = GetItemPossessedBy(oPC, "cdkeytoken");
string sPCCDKEY = GetPCPublicCDKey(oPC);
if (oCDTOKEN != OBJECT_INVALID)
{
if (GetDescription(oCDTOKEN) == "Invalid")
{SetDescription(oCDTOKEN, sPCCDKEY);}
if (GetDescription(oCDTOKEN) != sPCCDKEY)
    {SendMessageToAllDMs(GetName(oPC)+" CD-Key does not match CD-Key item and has been booted CDKEY: "+sPCCDKEY); BootPC(oPC);}
}


if (oCDTOKEN == OBJECT_INVALID)
{
object oNewToken = CreateItemOnObject("amy_cdkeytoken", oPC);
SetDescription(oNewToken, sPCCDKEY);
}
}
