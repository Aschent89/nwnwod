#include "ccs_inc"

int StartingConditional()
{
    int nClassType=CLASS_TYPE_MONK;
    object oPC=GetPCSpeaker();
    object oTrainer=GetLocalObject(oPC,"PC_TRAINER");
    if(!GetIsObjectValid(oTrainer) && !GetIsPC(oTrainer))
        oTrainer=OBJECT_SELF;
    if(!GetLevelByClass(nClassType,oTrainer))
        return FALSE;
    if(GetAlignmentLawChaos(oPC) != ALIGNMENT_LAWFUL)
        return FALSE;
    else
        return TRUE;
}
