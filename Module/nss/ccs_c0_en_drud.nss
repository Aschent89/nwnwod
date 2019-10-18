#include "ccs_inc"

int StartingConditional()
{
    int nClassType=CLASS_TYPE_DRUID;
    object oPC=GetPCSpeaker();
    object oTrainer=GetLocalObject(oPC,"PC_TRAINER");
    if(!GetIsObjectValid(oTrainer) && !GetIsPC(oTrainer))
        oTrainer=OBJECT_SELF;
    if(!GetLevelByClass(nClassType,oTrainer))
        return FALSE;
    if(GetAlignmentLawChaos(oPC) == ALIGNMENT_NEUTRAL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
        return TRUE;
    else
        return FALSE;
}
