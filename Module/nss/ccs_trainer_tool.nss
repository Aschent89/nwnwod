////////////////////////////////////////////////////////////////////////////////
///
/// Class Control System (CCS)
/// Created on 11/25/03 by DarthJohn
/// Last Modified on 02/02/04 by DarthJohn
/// Originally based on HCR code (http://www.rpging.net/nwn).
///
/// Script: ccs_trainer_tool
///
////////////////////////////////////////////////////////////////////////////////
///
/// DO NOT EDIT THIS SCRIPT!
/// This script spawns the invisible placeable that starts the trainer
/// conversation between the PC trainer and the PC trainee.
///
////////////////////////////////////////////////////////////////////////////////

#include "ccs_text"

void main()
{
    object oPC=GetItemActivator();
    object oOther=GetItemActivatedTarget();
    if(oOther == OBJECT_INVALID){
        FloatingTextStringOnCreature(PCTRAINSELECTPC,oPC,FALSE);
        return;
    }
    if(GetDistanceToObject(oOther) > 3.0){
        FloatingTextStringOnCreature(PCTRAINCLOSER,oPC,FALSE);
        return;
    }
    if(!GetIsPC(oOther)){
        FloatingTextStringOnCreature(PCTRAINONLYPC,oPC,FALSE);
        return;
    }
    if(oPC == oOther){
        FloatingTextStringOnCreature(PCTRAINNOSELF,oPC,FALSE);
        return;
    }
    location lLoc=GetLocation(oOther);
    SetLocalObject(oOther,"PC_TRAINER",oPC);
    CreateObject(OBJECT_TYPE_PLACEABLE,"ccs_conv_",lLoc);
    AssignCommand(oOther,ClearAllActions());
    DelayCommand(1.3,AssignCommand(GetNearestObjectByTag("CCS_CONV_",oOther),ActionStartConversation(oOther,"",TRUE,FALSE)));
}
