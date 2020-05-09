// Inspiration

void main()
{
    object oPC = OBJECT_SELF;
    if (GetLocalInt(oPC, "nInspire")==0)
    {
        int nDC = 9;
        int nCheck = d20()+GetAbilityModifier(ABILITY_CHARISMA, oPC);
        float fDur = 6.0*GetAbilityModifier(ABILITY_CHARISMA, oPC);
        int nBonus = 2;
        if (nCheck > nDC)
        {
            SetLocalInt(oPC, "nInspire", 1);
            DelayCommand(fDur, SetLocalInt(oPC, "nInspire", 0));
            FloatingTextStringOnCreature("Charisma check: "+IntToString(nCheck), oPC);

            object oTarg = GetFirstFactionMember(oPC);
            while (GetIsObjectValid(oTarg))
            {
                if (GetDistanceToObject(oTarg) < 10.0)
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_ALL_SKILLS, nBonus), oTarg, fDur);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(nBonus), oTarg, fDur);
                }
                oTarg = GetNextFactionMember(oPC, TRUE);
            }

        }
        else
            FloatingTextStringOnCreature(GetName(oPC)+" fails.  Charisma check: "+IntToString(nCheck), oPC);
    }
    else
         FloatingTextStringOnCreature("Inspiration still in effect.", oPC);




}
