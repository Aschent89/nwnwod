void main()
{

object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);

if (IsInConversation(OBJECT_SELF) || GetIsInCombat()) return;

object oTarget;
oTarget = GetObjectByTag("StravoWailsMen");

SoundObjectSetPosition(oTarget, GetPosition(oPC));

oTarget = GetObjectByTag("stravoFliesLoopMen");

SoundObjectSetPosition(oTarget, GetPosition(oPC));

     ClearAllActions();
     ActionRandomWalk();

}
