#include "toy_source"
int StartingConditional()
{
    object oMaster = GetPCSpeaker();
    object oSlave = GetLocalObject(oMaster, "MR_COLLAR_SLAVE");
    string sName = GetName(oSlave);
    string sGender;
    switch (GetGender(oSlave)) {
        case GENDER_FEMALE : sGender = "her"; break;
        case GENDER_MALE : sGender = "his"; break;}

    SetCustomToken(9987, sName);
    SetCustomToken(9985, sGender);
    return TRUE;

}
