#include "bbs_include"

void main()
{
  object oPC = GetPCSpeaker();

  object oAvatar = CreateObject(OBJECT_TYPE_CREATURE, "bbs_scribe_bp", GetLocation(OBJECT_SELF), FALSE);
  AssignCommand(oPC,ClearAllActions());

  effect eVis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
  effect eImmobilize = EffectCutsceneImmobilize();
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oAvatar);
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, eImmobilize, oAvatar);

  AssignCommand(oAvatar,ActionStartConversation(oPC, "bbs_scribe", TRUE, FALSE));
}
