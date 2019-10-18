
void main()
{
object oPC;

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_FAIRY);

effect eEffect;
eEffect = EffectAbilityIncrease(ABILITY_DEXTERITY, 6);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 120.0f);

eEffect = EffectAbilityDecrease(ABILITY_STRENGTH, 6);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 120.0f);

eEffect = EffectACIncrease(4);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 120.0f);

eEffect = EffectSkillIncrease(SKILL_OPEN_LOCK, 20);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 120.0f);

eEffect = EffectSkillIncrease(SKILL_DISABLE_TRAP, 20);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 120.0f);

eEffect = EffectSkillIncrease(SKILL_PICK_POCKET, 20);

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 120.0f);

if ((GetRacialType(oPC)==RACIAL_TYPE_GNOME))
   {
   oTarget = oPC;

   DelayCommand(121.0, SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_GNOME));

   }
else if ((GetRacialType(oPC)==RACIAL_TYPE_ELF))
   {
   oTarget = oPC;

   DelayCommand(121.0, SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_ELF));

   }
else if ((GetRacialType(oPC)==RACIAL_TYPE_DWARF))
   {
   oTarget = oPC;

   DelayCommand(121.0, SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_DWARF));

   }

else if ((GetRacialType(oPC)==RACIAL_TYPE_HALFELF))
   {
   oTarget = oPC;

   DelayCommand(121.0, SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_HALF_ELF));

   }
else if ((GetRacialType(oPC)==RACIAL_TYPE_HALFORC))
   {
   oTarget = oPC;

   DelayCommand(121.0, SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_HALF_ORC));

   }
else if ((GetRacialType(oPC)==RACIAL_TYPE_HALFLING))
   {
   oTarget = oPC;

   DelayCommand(121.0, SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_HALFLING));

   }

else if ((GetRacialType(oPC)==RACIAL_TYPE_HUMAN))
   {
   oTarget = oPC;

   DelayCommand(121.0, SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_HUMAN));

   }
}
