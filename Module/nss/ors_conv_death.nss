////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Player Stat's
//  ors_conv_death
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

    //Name of Player Character
    string sPC = GetName(oPC);
    DelayCommand(1.0,FloatingTextStringOnCreature(BLUISHG+"Stats for "+BLUISHR+sPC,oPC,FALSE));
    DelayCommand(1.1,SendMessageToAllDMs(BLUISHG+"Stats for "+BLUISHR+sPC));
    DelayCommand(1.5,FloatingTextStringOnCreature("",oPC,FALSE));

    //Player Character Number of Times Died
    string sTimesDied = ORS_GetTotalDeaths(oPC);
    SetCustomToken(42004, GRAY+"Total Deaths: "+WHITE+sTimesDied);
}
