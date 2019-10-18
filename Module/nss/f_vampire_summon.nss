#include "f_vampire_h"

void main()
{
effect eSummon;
location lTarget = GetLocation(OBJECT_SELF);
int iDur = Determine_Vampire_Level() / 6;
if(iDur < 1) iDur = 1;
if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_TWIN_ABYSS, OBJECT_SELF))
    {
    switch(Random(3))
        {
        case 0:
            eSummon = EffectSummonCreature("handofevil",496,1.0f);
            break;
        case 1:
            eSummon = EffectSummonCreature("undeadslime", VFX_FNF_GAS_EXPLOSION_GREASE);
            break;
        case 2:
            eSummon = EffectSummonCreature("dragonshad002",481,0.0f,TRUE);
            break;
        }
    if(Random(6) > 0)
        {
        eSummon = ExtraordinaryEffect(eSummon);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lTarget, HoursToSeconds(iDur));
        return;
        }
    }
if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_KIN_DAMNED, OBJECT_SELF))
    {
    switch(Random(3))
        {
        case 0:
            eSummon = EffectSummonCreature("vengence", VFX_FNF_WORD);
            break;
        case 1:
            eSummon = EffectSummonCreature("pain", VFX_FNF_WORD);
            break;
        case 2:
            eSummon = EffectSummonCreature("hate", VFX_FNF_WORD);
            break;
        }
    if(Random(6) > 0)
        {
        eSummon = ExtraordinaryEffect(eSummon);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lTarget, HoursToSeconds(iDur));
        return;
        }
    }
if(GetHasEpicAbility(FALLEN_VAMPIRE_EPIC_CHILDREN_NIGHT, OBJECT_SELF))
    {
    switch(Random(3))
        {
        case 0:
            eSummon = EffectSummonCreature("ancientbat", VFX_IMP_HARM, 0.0, 1);
            break;
        case 1:
            eSummon = EffectSummonCreature("spiderlord", VFX_FNF_LOS_EVIL_20);
            break;
        case 2:
            eSummon = EffectSummonCreature("plaguerat", VFX_IMP_DISEASE_S);
            break;
        }
    eSummon = ExtraordinaryEffect(eSummon);
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, lTarget, HoursToSeconds(iDur));
    }
}
