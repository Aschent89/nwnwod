void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();

object oTarget;
oTarget = oPC;

SetCreatureAppearanceType(oTarget, 1868);

effect eEffect;
eEffect = EffectAbilityIncrease(ABILITY_CONSTITUTION, 6);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 90.0f);

eEffect = EffectACIncrease(5);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 90.0f);

eEffect = EffectImmunity(IMMUNITY_TYPE_POISON);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 90.0f);

eEffect = EffectDamageIncrease(DAMAGE_BONUS_2d6, DAMAGE_TYPE_ACID);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 90.0f);

if ((GetRacialType(oPC)==RACIAL_TYPE_GNOME))
   {
   oTarget = oPC;

   DelayCommand(91.0, SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_GNOME));

   }
else if ((GetRacialType(oPC)==RACIAL_TYPE_ELF))
   {
   oTarget = oPC;

   DelayCommand(91.0, SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_ELF));

   }
else if ((GetRacialType(oPC)==RACIAL_TYPE_DWARF))
   {
   oTarget = oPC;

   DelayCommand(91.0, SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_DWARF));

   }

else if ((GetRacialType(oPC)==RACIAL_TYPE_HALFELF))
   {
   oTarget = oPC;

   DelayCommand(91.0, SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_HALF_ELF));

   }
else if ((GetRacialType(oPC)==RACIAL_TYPE_HALFORC))
   {
   oTarget = oPC;

   DelayCommand(91.0, SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_HALF_ORC));

   }
else if ((GetRacialType(oPC)==RACIAL_TYPE_HALFLING))
   {
   oTarget = oPC;

   DelayCommand(91.0, SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_HALFLING));

   }

else if ((GetRacialType(oPC)==RACIAL_TYPE_HUMAN))
   {
   oTarget = oPC;

   DelayCommand(91.0, SetCreatureAppearanceType(oTarget, APPEARANCE_TYPE_HUMAN));

   }
}
