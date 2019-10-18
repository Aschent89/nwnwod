////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Mercenary Alignment Shift
//  ors_merc_good
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from XP Giver Convo
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    AdjustAlignment(oPC, ALIGNMENT_GOOD, 100);

    //Boot PC from Server
    BootPC(oPC);
}
