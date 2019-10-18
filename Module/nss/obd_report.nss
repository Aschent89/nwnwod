////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_report
//  By Don Anderson
//  dandersonru@msn.com
//
//  This will report the bound location of the Player's
//  the last saved Binding Stone or the Default place
//
////////////////////////////////////////////////////////////////////////////////

#include "obd_include"

void main()
{
    object oPC = GetPCSpeaker();
    string sDB = OBD_GetDBString();

    string sBindPointTag = NBDE_GetCampaignString(sDB,"BS_LASTBINDPOINT",oPC);
    object oBindPoint = GetObjectByTag(sBindPointTag);
    string sBindPointName = GetName(oBindPoint);
    string sSay = "You are currently bound to the " + sBindPointName;
    SendMessageToPC(oPC,sSay);
}
