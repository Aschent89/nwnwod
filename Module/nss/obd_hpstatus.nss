////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Binding Stones/Bleeding/Death
//  obd_hpstatus
//  By Don Anderson
//  dandersonru@msn.com
//
//  This makes Player's Current HP Persistent
//
//  Place this in the Module OnClient Enter Event
//
////////////////////////////////////////////////////////////////////////////////

#include "obd_include"

void HPLoop(object oPC)
{
    object oMod = GetModule();
    float fHPInv = 60.0;
    string sDB = OBD_GetDBString();

    //Current HP's
    int nHPStatus = GetCurrentHitPoints(oPC);
    NBDE_SetCampaignInt(sDB,"HP",nHPStatus,oPC);

    //Continuously Loop checks per Global Value
    DelayCommand(fHPInv,HPLoop(oPC));
}

void main()
{
    object oMod = GetModule();
    float fHPInv = 60.0;

    object oPC = GetEnteringObject();

    //Don't go further if this is a DM
    if(GetIsDM(oPC) == TRUE || GetIsDMPossessed(oPC) == TRUE) return;

    //Don't go further if this is not a Player
    if(GetIsPC(oPC) == FALSE) return;

    //Start HP and Bleed Status Persistency
    DelayCommand(fHPInv,HPLoop(oPC));
}
