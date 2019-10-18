#include "ccs_inc"

int StartingConditional()
{
    int nClassType=CLASS_TYPE_PALADIN;
    object oPC=GetPCSpeaker();
    object oTrainer=GetLocalObject(oPC,"PC_TRAINER");
    if(!GetIsObjectValid(oTrainer) && !GetIsPC(oTrainer))
        oTrainer=OBJECT_SELF;
    if(!GetLevelByClass(nClassType,oTrainer))
        return FALSE;
    if(GetAlignmentLawChaos(oPC) == ALIGNMENT_LAWFUL && GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
        return TRUE;
    else
        return FALSE;
}
