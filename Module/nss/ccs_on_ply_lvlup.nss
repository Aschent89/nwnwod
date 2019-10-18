////////////////////////////////////////////////////////////////////////////////
///
/// Class Control System (CCS)
/// Created on 11/25/03 by DarthJohn
/// Last Modified on 01/12/04 by DarthJohn
/// Originally based on HCR code (http://www.rpging.net/nwn)
///
/// Script: ccs_on_ply_lvlup
///
////////////////////////////////////////////////////////////////////////////////
///
/// DO NOT EDIT THIS SCRIPT!
/// This script should go in your OnPlayerLevelUp module event.
///
////////////////////////////////////////////////////////////////////////////////

#include "ccs_inc"
#include "ccs_text"
#include "q_stackable_inc"

void main()
{
    object oPC=GetPCLevellingUp();
    int nHD=GetHitDice(oPC);

    if(CCS_CHARACTER_LEVEL_CONTROL)
    {
        if(nHD >= CCS_TRAINER_START)
        {
            if(!GetLocalInt(oPC,"ALLOWLEVEL"))
            {
                SendMessageToPC(oPC,GAINLEVEL);
                if(CCS_XP_LEVEL_CAP)
                {
                    int nNewXP = ((nHD * (nHD-1)) / 2 * 1000)-1;
                    SetXP(oPC, nNewXP);
        //Added to handle levelup point removal when not able to level up yet
       ActionTakeStackedItemsByTag("vamppoint",GetPCLevellingUp(),1);
       ActionTakeStackedItemsByTag("garougnoisepoint",GetPCLevellingUp(),1);
       ActionTakeStackedItemsByTag("hunterspoint",GetPCLevellingUp(),1);
                }
                BlockAllClasses(oPC);
            }
            else DeleteLocalInt(oPC,"ALLOWLEVEL");
        }
        else if(CCS_TRAINER_START && CCS_MULTICLASS_LEVEL_CONTROL)
        {
            EnableFamiliarClasses(oPC);
        }
        else if(!CCS_MULTICLASS_LEVEL_CONTROL)
        {
            AllowAllClasses(oPC);
        }
    }
}
