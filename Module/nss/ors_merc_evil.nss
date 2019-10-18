////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Mercenary Alignment Shift
//  ors_merc_evil
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from XP Giver Convo
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    AdjustAlignment(oPC, ALIGNMENT_EVIL, 100);

    //Boot PC from Server
    BootPC(oPC);
}
