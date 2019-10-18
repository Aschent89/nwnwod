////////////////////////////////////////////////////////////////////////////////
//
//  Olander's PW XP System
//  xp_opw_system
//  by Don Anderson
//
//  Original Script by Brian Kittrell
//
/*
  - Minimum XP Per Kill
  - Maximum XP Per Kill
  - Kill Bonus to Killer
  - Party Bonus
  - Arcane Class Bonus with Level Cap for the Bonus
  - Players above Maximum Level Difference to Lowest Level are Thrown out
  - Maximum Level Cap to Give XP (The Level Set still gets XP)
  - CR Difference Cutoff...Averaged to Party Level
  - Distance Cutoff in Meters
*/
//
//  This pretty much puts an end to power levelling but
//  still allows low and high levels to travel together
//  and work together as a team.
//
//  This also penalizes for killing Commoners too
//
////////////////////////////////////////////////////////////////////////////////

//SET THE EXPERIENCE VALUES HERE
/*
    // This is the minimum amount of experience that is given
    // to each player. Set this to be as aggressive or slow
    // as needed to achieve a good result.
    // NOTE:    This has the effect of levelling quickly in the
    //          lower levels and naturally slowing down in the
    //          higher levels.
    int nNXP = 5;

    //  This is the Bonus Received for the Kill
    int nKXP = 5;

    //Arcane Classes need a Little Boost for Low Levels?
    int nAXP = 1;

    //Cap to Arcane Class Bonus
    int nAXPC = 10;

    //Low Level Bonus (Levels up to 10)
    int nLLB = 5;

    //Mid Level Bonus (Levels 11 to 20)
    int nMLB = 3;

    //Epic Level Bonus (Levels 21+)
    int nELB = 0;

    //CR Differential to keep Kill Bonus (Player Level - CR of Creature)
    int nCRDiff = 40;

    //  This is the RATE that determines party bonus. Adjust this
    //  as necessary to get the disired result.
    //  This is calculated to the CR of the creature Killed
    int nBXP = 10;

    //This is the Maximum XP for ANY Creature in a Module
    int nMXP = 200;

    //Maximum Level Difference from Highest to Lowest Level
    //Set to 40 To Basically Disable
    int nMLD = 40;

    //Maximum Level to Give XP
    int nMLXP = 40;

    //Maximum Distance to Killer to Receive XP
    float fMD = 45.0;

void main()
{
    int nCommoner = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    object oKiller = GetLastKiller();
    object oTKiller = GetTrapCreator(oKiller);
    if(GetIsObjectValid(oTKiller)) oKiller = oTKiller;
    object oMember;
    object oArea = GetArea(oKiller);
    int nMember = 0;
    int nLLevel = 40;
    int nNParty = 0;
    int nLParty = 0;
    int nBFValue = 0;
    int nFMValue;

    // Check if the PC killed a Commoner
    // If YES shift 5 points towards Evil
    if (GetIsPC(oKiller) || GetIsPC(GetMaster(oKiller)))
    {
      int nCommoner = GetLevelByClass(CLASS_TYPE_COMMONER);
      int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
      if(nCommoner > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL || nAlign == ALIGNMENT_EVIL ))
      {
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
      }

      //Now we calculate the total CR Bonus XP
      float fCRRating = GetChallengeRating(OBJECT_SELF);
      float fCRBonusXP = fCRRating * IntToFloat(nBXP);
      int nCRBonusXP = FloatToInt(fCRBonusXP);

      //First We need the Lowest Level Player
      oMember = GetFirstFactionMember(oKiller, TRUE);
      while(GetIsObjectValid(oMember))
      {
        if((GetDistanceBetween(OBJECT_SELF, oMember) <= fMD) && (GetArea(OBJECT_SELF) == GetArea(oMember)))
        {
          nMember = GetHitDice(oMember);
          if(nMember < nLLevel) nLLevel = nMember;
        }
        oMember = GetNextFactionMember(oKiller, TRUE);
      }

      //All party members in the area of the kill will get XP Unless Outside of Range
      oMember = GetFirstFactionMember(oKiller, TRUE);
      while(GetIsObjectValid(oMember))
      {
        if((GetDistanceBetween(OBJECT_SELF, oMember) <= fMD) && (GetArea(OBJECT_SELF) == GetArea(oMember)))
        {
          nMember = GetHitDice(oMember);
          nNParty++;
          if(nMember <= (nMLD + nLLevel))
          {
            nLParty += nMember;
            SetLocalInt(oMember,"XP_ELIGIBLE",1);
          }
        }
        oMember = GetNextFactionMember(oKiller, TRUE);
      }

      //Now we set the Average Party Level
      if(nNParty <= 0) nNParty = 1;
      int nAVGParty = nLParty / nNParty;
      if(nAVGParty <= 0) nAVGParty = 1;

      //Now we split the Bonus between all party members
      int nBonusXP = nCRBonusXP / nAVGParty;

      //Now we set the Bonus to 0 or more
      if (nBonusXP > 0)
      {
        nBFValue = nBonusXP;
      }

      //This is the Final Total Experience Given to Players
      int nFLLB = nLLB + nNXP + nBFValue;
      int nFMLB = nMLB + nNXP + nBFValue;
      int nFELB = nELB + nNXP + nBFValue;

      int nFinalXP = nNXP + nBFValue;
      if(nFinalXP > nMXP) nFinalXP = nMXP;

      //ORS Pets Share 50% of the Kill XP to the Owner ONLY
      int nPet = GetLocalInt(oKiller,"PET");
      if(nPet == 1)
      {
        object oPC = GetLocalObject(oKiller,"OPE_OWNER");
        int nOPEXP = nFinalXP/2;
        if(nOPEXP < nNXP) nOPEXP = nNXP;
        GiveXPToCreature(oPC, nOPEXP);
        return;
      }

      //Now we give XP to all in the Party
      oMember = GetFirstFactionMember(oKiller, TRUE);
      int nXPE; int nClass; int nGXP; int nABonus;
      while (GetIsObjectValid(oMember))
      {
        nGXP = nFinalXP;
        nXPE = GetLocalInt(oMember,"XP_ELIGIBLE");
        nMember = GetHitDice(oMember);
        if(nXPE == 1 && nMember <= nMLXP)
        {
          //Remove XP Eligible Status
          SetLocalInt(oMember,"XP_ELIGIBLE",0);

          //Arcane Class Bonuses
          nClass = GetClassByPosition(1,oMember);
          nABonus = FALSE;
          if(nClass == CLASS_TYPE_BARD) nABonus = TRUE;
          if(nClass == CLASS_TYPE_WIZARD) nABonus = TRUE;
          if(nClass == CLASS_TYPE_SORCERER) nABonus = TRUE;

          //The Killer gets the Kill Bonus
          if(oMember == oKiller)
          {
            //Check for no Kill Bonus for Easy Creatures
            float fDCheck = IntToFloat(nMember) - fCRRating;
            if(fDCheck < IntToFloat(nCRDiff))
            {
              nGXP = nFinalXP + nKXP;
            }
          }

          //Arcane Bonus
          if((nABonus == TRUE) && (GetHitDice(oMember) <= nAXPC))
          {
            nGXP = nGXP + nAXP;
          }

          //Level Bonus (See Configs Above)
          if(nMember < 10) nGXP = nGXP + nLLB;
          if(nMember > 10 && nMember < 21) nGXP = nGXP + nMLB;
          if(nMember > 20) nGXP = nGXP + nELB;

          //For Easy Kill High Levellers...Only Get Minimum
          if(nMember >= nCRDiff)
          {
            float fEKill = IntToFloat(nMember) - fCRRating;
            if(fEKill > IntToFloat(nCRDiff))
            {
              nGXP = nNXP;
            }
          }

          GiveXPToCreature(oMember, nGXP);
        }
        oMember = GetNextFactionMember(oKiller, TRUE);
      }
    }
}
*/
