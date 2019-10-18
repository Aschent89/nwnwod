////////////////////////////////////////////////////////////////////////////////
//
//  Olander's PW Player Kill XP System
//  xp_pvp_system
//  by Don Anderson
//  dandersonru@msn.com
//
//  This gives XP for Player Kills (Party gets XP Distributed....Configurable Below)
/*
To Set this up:

Place in the On Death Event Script:

//Player Kill XP
ExecuteScript("xp_pvp_system",oDead);

This could be placed in the Wrapper (if you use them) or the Actual Script
*/
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

//SET THE EXPERIENCE VALUES HERE

    // This is the minimum amount of experience that is given for a Player Kill to the PARTY (See Below)
    int nNXP = 250;

    // This is the Bonus Received for a Player Kill Per Level Above the Player (For Killer Only)
    int nKXP = 50;

    // This is the Above Level Cap for PvP Limit (For Killer Only)
    int nLCap = 5;

    // This is the PvP Easy Rating (level Difference) For Player Kill Violations
    int nEasyRating = 8;

    // This is the Cap per PvP kill FOR THE KILLER and also the Cap Party XP (For Killer Only)
    int nMXP = nKXP * nLCap;

    // Gold Pocket Bonus for the Killer (Range 0.00 to 1.00) (For Killer Only)
    float fGBonus = 0.20;

void main()
{
    object oDead = OBJECT_SELF;
    object oKiller = GetLocalObject(oDead,"ORS_PCKILLER");
    int nAlignDead = GetAlignmentGoodEvil(oDead);
    int nAlignKiller = GetAlignmentGoodEvil(oKiller);

    int nNParty = 0;
    int nLParty = 0;
    int nBFValue = 0;
    int nFMValue;

    //Was the Killer a Player
    if(GetIsPC(oKiller) == FALSE) return;

    //Alignment Shift and XP
    if(GetIsPC(oKiller) == TRUE)
    {
      //Evil Killer Gets More Evil
      if((nAlignDead == ALIGNMENT_GOOD || nAlignDead == ALIGNMENT_NEUTRAL || nAlignDead == ALIGNMENT_EVIL )
        && nAlignKiller == ALIGNMENT_EVIL)
      {
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
      }

      //Good and Neutral Get More Good When Killing Evil
      if(nAlignDead == ALIGNMENT_EVIL && (nAlignKiller == ALIGNMENT_GOOD || nAlignKiller == ALIGNMENT_NEUTRAL))
      {
        AdjustAlignment(oKiller, ALIGNMENT_GOOD, 5);
      }

      //Good and Neutral Get More Evil When Killing Neutral
      if(nAlignDead == ALIGNMENT_NEUTRAL && (nAlignKiller == ALIGNMENT_GOOD || nAlignKiller == ALIGNMENT_NEUTRAL))
      {
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
      }

      //Now we Get the Level of the Dead and Killer
      int nDeadHD = GetHitDice(oDead);
      int nKillerHD = GetHitDice(oKiller);
      int nDiff = 0;
      if(nKillerHD > nDeadHD) nDiff = nKillerHD - nDeadHD;
      if(nDiff > nLCap) nDiff = nLCap;

      //This is the Minimum XP (Capped) to Each Party Member
      int nPXP = nNXP;
      if(nPXP > nMXP) nPXP = nMXP;

      //This is the Minimum XP (Capped) to the Killer
      int nKPXP = nNXP + (nDiff * nKXP);
      if(nKPXP > nMXP) nKPXP = nMXP;

      //How much Gold Does the Dead Have
      float fDeadGold = IntToFloat(GetGold(oDead));
      float fPercentage = fDeadGold * fGBonus;
      int nKillGold = FloatToInt(fPercentage);

      object oMember;

/******************************************************************************/
//: PvP RATING VIOLATION

      if(nDiff > 0 && nDiff > nEasyRating)
      {
        SendMessageToPC(oKiller, "You have made an Easy Player Kill Violation. You Die because of it.");
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetMaxHitPoints(oKiller) + 1000), oKiller);
        return;
      }

//: PvP RATING VIOLATION
/******************************************************************************/

/******************************************************************************/
//: DISTRIBUTED MINIMUM XP (SPLIT MIN XP)

      //All party members in the area of the kill will get XP
      int nNParty = 0;
      oMember = GetFirstFactionMember(oKiller, TRUE);
      while(GetIsObjectValid(oMember) && GetArea(OBJECT_SELF) == GetArea(oMember))
      {
        nNParty++;
        oMember = GetNextFactionMember(oKiller, TRUE);
      }

      //Now we split the Bonus between all party members
      if(nNParty <= 0) nNParty = 1;

      //int nPartyXP = nPXP; //Use this Line for No Splitting
      int nPartyXP = nPXP / nNParty; //Use this Line for Splitting

//: DISTRIBUTED MINIMUM XP (SPLIT MIN XP)
/******************************************************************************/

      //Now we give XP to all in the Party
      oMember = GetFirstFactionMember(oKiller, TRUE);
      while (GetIsObjectValid(oMember) && GetArea(OBJECT_SELF) == GetArea(oMember))
      {
        //The Killer gets the Kill Bonus or Gets Soul Rune Removed for Rating Violations
        if(oMember == oKiller)
        {
          GiveXPToCreature(oMember, nKPXP);
          GiveGoldToCreature(oMember, nKillGold);
        }

        //Players in the Same Party Don't Get XP
        if(GetFactionEqual(oMember,oKiller) == FALSE)
        {
          GiveXPToCreature(oMember, nPartyXP);
        }
        oMember = GetNextFactionMember(oKiller, TRUE);
      }
    }
}
