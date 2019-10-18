void main()
{

object oPC = GetExitingObject();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = GetFirstEffect(oTarget);
while (GetIsEffectValid(eEffect))
   {
   if (GetEffectType(eEffect)==EFFECT_TYPE_REGENERATE) RemoveEffect(oTarget, eEffect);
   eEffect = GetNextEffect(oTarget);
   }

}
