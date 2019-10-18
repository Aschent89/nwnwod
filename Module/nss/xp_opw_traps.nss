////////////////////////////////////////////////////////////////////////////////
//
//  Olander's PW XP System For Traps
//  xp_opw_traps
//  by Don Anderson
//  dandersonru@msn.com
//
//  This gives XP for Disarming Traps
//
//  Disarm list is set to the Player so when they log back in the traps can be
//  disarmed again for XP.
//
//  Set this script to the Trap OnDisarm Event
//
////////////////////////////////////////////////////////////////////////////////

//SET THE EXPERIENCE VALUES HERE

    //This is the Disarm XP Bonus Added to the Trap Disarm DC
    int nDXPBonus = 25;

    //This is the Minimum Trap Disarm DC to receive XP
    int nDDCMin = 10;

    //This is the Maximum Trap Disarm XP
    int nDXPMax = 75;

void main()
{
    object oPC = GetLastDisarmed();
    object oTrap = OBJECT_SELF;
    string sTrap = GetTag(oTrap);
    string sTrapSet = "TrapSet" + sTrap;
    int nTrapSet = GetTrapDisarmDC(oTrap);
    int nDisarmed = GetLocalInt(oPC,sTrapSet);
    int nDisarmXP = 0;

    //Stop is DM or NPC's
    if(GetIsDM(oPC) == TRUE) return;
    if(GetIsPC(oPC) == FALSE) return;

    //Not Picked Before
    if(nDisarmed == 0)
    {
      //If the Trap is very easy No XP
      if(nTrapSet < nDDCMin) return;

      //Set the XP Value Given
      nDisarmXP = nTrapSet + nDXPBonus;

      //If the Trap is Very Diffiult set Maximum XP
      if(nDisarmXP > nDXPMax) nDisarmXP = nDXPMax;

      //Now give the XP
      GiveXPToCreature(oPC,nDisarmXP);
      SendMessageToPC(oPC,"I have gained XP using my Trap Disarm Skill.");
      SetLocalInt(oPC,sTrapSet,1);
    }
}
