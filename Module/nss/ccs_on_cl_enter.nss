////////////////////////////////////////////////////////////////////////////////
///
/// Class Control System (CCS)
/// Created on 11/25/03 by DarthJohn
/// Last Modified on 12/22/03 by DarthJohn
/// Originally based on HCR code (http://www.rpging.net/nwn)
///
/// Script: ccs_on_cl_enter
///
////////////////////////////////////////////////////////////////////////////////
///
/// DO NOT EDIT THIS SCRIPT!
/// This is script should go in your OnClientEnter module event.
///
////////////////////////////////////////////////////////////////////////////////

#include "ccs_inc"

void main()
{
    object oMod=GetModule();
    object oPC=GetEnteringObject();

    if(CCS_CHARACTER_LEVEL_CONTROL){
        if(GetIsPC(oPC)){
            BlockAllClasses(oPC);
            if(CCS_TRAINER_START && CCS_MULTICLASS_LEVEL_CONTROL){
                EnableFamiliarClasses(oPC);
            }
            else if(!CCS_MULTICLASS_LEVEL_CONTROL){
                AllowAllClasses(oPC);
            }
        }
    }
}
