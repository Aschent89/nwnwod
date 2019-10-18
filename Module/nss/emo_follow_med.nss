void main()
{
    object oPC = GetPCSpeaker();
    object oFollow = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oPC, 1, CREATURE_TYPE_IS_ALIVE, TRUE);

    if(!GetIsObjectValid(oFollow)) {
        FloatingTextStringOnCreature("No players to follow!", oPC, FALSE);
        return; }

    AssignCommand(oPC, ActionForceFollowObject(oFollow, 3.0));

}
