////////////////////////////////////////////////////////////////////////////////
//
//  Olander's PW XP System For Lock Picks
//  xp_opw_locks
//  by Don Anderson
//  dandersonru@msn.com
//
//  This gives XP for opening locks
//
//  Lock list is set to the Player so when they log back in the locks can be
//  unlocked again for XP.
//
//  Set this script to the Door or Placeable OnUnlock Event
//
////////////////////////////////////////////////////////////////////////////////

#include "x0_i0_spells"

//SET THE EXPERIENCE VALUES HERE

    //This is the Lock Pick XP Bonus Added to the Lock DC
    int nLPXPBonus = 25;

    //This is the Minimum Lock Pick DC to receive XP
    int nLPDCMin = 10;

    //This is the Maximum Lock Pick XP
    int nLPXPMax = 75;

void main()
{
    object oPC = GetLastUnlocked();
    object oLock = OBJECT_SELF;
    string sLock = GetTag(oLock);
    string sLockSet = "LockSet" + sLock;
    int nLockSet = GetLockUnlockDC(oLock);
    int nPicked = GetLocalInt(oPC,sLockSet);
    int nPickXP = 0;

    //Stop is DM or NPC's
    if(GetIsDM(oPC) == TRUE) return;
    if(GetIsPC(oPC) == FALSE) return;

    //Remove Invisibility
    if (GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY, oPC) == TRUE)
    {
      RemoveAnySpellEffects(SPELL_IMPROVED_INVISIBILITY, oPC);
    }
    else if (GetHasSpellEffect(SPELL_INVISIBILITY, oPC) == TRUE)
    {
      RemoveAnySpellEffects(SPELL_INVISIBILITY, oPC);
    }
    else if (GetHasSpellEffect(SPELLABILITY_AS_INVISIBILITY, oPC) == TRUE)
    {
      RemoveAnySpellEffects(SPELLABILITY_AS_INVISIBILITY, oPC);
    }
    else if(GetHasSpellEffect(SPELLABILITY_AS_IMPROVED_INVISIBLITY, oPC) == TRUE)
    {
      RemoveAnySpellEffects(SPELLABILITY_AS_IMPROVED_INVISIBLITY, oPC);
    }

    //Not Picked Before
    if(nPicked == 0)
    {
      //If the Lock is very easy No XP
      if(nLockSet < nLPDCMin) return;

      //Set the XP Value Given
      nPickXP = nLockSet + nLPXPBonus;

      //If the Lock is Very Diffiult set Maximum XP
      if(nPickXP > nLPXPMax) nPickXP = nLPXPMax;

      //Now give the XP
      GiveXPToCreature(oPC,nPickXP);
      SendMessageToPC(oPC,"I have gained XP using my Lockpicking Skill.");
      SetLocalInt(oPC,sLockSet,1);
    }
}
