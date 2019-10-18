void main()
{
object oTarget;
oTarget = OBJECT_SELF;

effect eEffect;
eEffect = EffectCutsceneGhost();

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

eEffect = EffectEthereal();

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

}
