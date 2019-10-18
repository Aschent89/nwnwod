////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Alignment Shift
//  ors_al_chaotic
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from XP Giver Convo
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, 5);
}
