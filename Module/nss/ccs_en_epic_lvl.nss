////////////////////////////////////////////////////////////////////////////////
///
/// Class Control System (CCS)
/// Created on 11/25/03 by DarthJohn
/// Last Modified on 01/12/04 by DarthJohn
/// Originally based on HCR code (http://www.rpging.net/nwn)
///
/// Script: ccs_en_epic_lvl
///
////////////////////////////////////////////////////////////////////////////////
///
/// DO NOT EDIT THIS SCRIPT!
/// This script was intended to fire from a conversation, if this script will
/// NOT fire from a conversation the object call will need to change to
/// GetEnteringObject() or GetLastKiller() or whatever. Make a copy of this
/// script and change the script as need be.
///
////////////////////////////////////////////////////////////////////////////////

#include "ccs_inc"

void main()
{
    object oPC=GetPCSpeaker();

    if(GetIsPC(oPC))
        SetCampaignInt(CCS_DATABASE,"ENABLE_EPIC_LEVELS",1,oPC);
}
