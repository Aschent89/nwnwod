////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Player Stat's
//  ors_conv_bday
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is called from the Rest Menu
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void main()
{
    object oPC = GetPCSpeaker();
    object oMod = GetModule();
    string sDB = ORS_GetDBString();

    //Name of Player Character
    string sPC = GetName(oPC);
    DelayCommand(1.0,FloatingTextStringOnCreature(BLUISHG+"Stats for "+BLUISHR+sPC,oPC,FALSE));
    DelayCommand(1.1,SendMessageToAllDMs(BLUISHG+"Stats for "+BLUISHR+sPC));
    DelayCommand(1.5,FloatingTextStringOnCreature("",oPC,FALSE));

    //Player Character Start Date
    int nYear = NBDE_GetCampaignInt(sDB, "PC_YEAR_START", oPC);
    string sMonth = NBDE_GetCampaignString(sDB, "PC_MONTH_START", oPC);
    int nDay = NBDE_GetCampaignInt(sDB, "PC_DAY_START", oPC);

    string sSuffix;
    if(nDay == 1) sSuffix = "st";
    if(nDay == 2) sSuffix = "nd";
    if(nDay == 3) sSuffix = "rd";
    if(nDay >= 4) sSuffix = "th";
    DelayCommand(2.0,FloatingTextStringOnCreature(YELLOW+"My Birthday: "+GREEN+sMonth+" "+IntToString(nDay)+sSuffix+", "+IntToString(nYear),oPC,FALSE));
    DelayCommand(4.1,SendMessageToAllDMs(YELLOW+"My Birthday: "+GREEN+sMonth+" "+IntToString(nDay)+sSuffix+", "+IntToString(nYear)));
}
