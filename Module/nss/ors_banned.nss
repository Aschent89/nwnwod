////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realsitic Systems - Banned Classes and Feats
//  ors_banned
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this in the Module OnPlayeLevelUp Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetPCLevellingUp();
  if (!GetIsPC(oPC)) return;

  int nRelevel = 0;

  //Dev Crit Not Allowed
  int nDCAllow = GetLocalInt(GetModule(),"DEVCRIT");
  if(nDCAllow == 1)
  {
     int nDevCrit = 0;
     //Now Check for DevCrit Feats Chosen at Level Up
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_BASTARDSWORD, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_BATTLEAXE, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_CLUB, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_DAGGER, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_DART, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_DIREMACE, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_DOUBLEAXE, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_DWAXE, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_GREATAXE, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_GREATSWORD, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_HALBERD, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_HANDAXE, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_HEAVYCROSSBOW, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_HEAVYFLAIL, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_KAMA, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_KATANA, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_KUKRI, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_LIGHTCROSSBOW, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_LIGHTFLAIL, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_LIGHTHAMMER, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_LIGHTMACE, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_LONGBOW, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_LONGSWORD, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_MORNINGSTAR, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_QUARTERSTAFF, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_RAPIER, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SCIMITAR, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SCYTHE, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SHORTBOW, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SHORTSPEAR, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SHORTSWORD, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SHURIKEN, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SICKLE, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_SLING, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_THROWINGAXE, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_TWOBLADEDSWORD, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_UNARMED, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_WARHAMMER, oPC)) nDevCrit = 1;
     if (GetHasFeat(FEAT_EPIC_DEVASTATING_CRITICAL_WHIP, oPC)) nDevCrit = 1;

     if (nDevCrit == 1)
     {
       nRelevel = 1;
       SendMessageToPC(oPC,"Devastating Critical is Forbidden! You will be relevelled!");
     }
  }

  //Circle Kick Relevel
  int nCK = 0;
  if(GetHasFeat(FEAT_CIRCLE_KICK, oPC)) nCK = 1;
  if(nCK == 1)
  {
    nRelevel = 1;
    SendMessageToPC(oPC,"You don't take the Circle Kick Feat......IT SUCKS......you will be relevelled! Cheers!");
  }

  if(nRelevel == 1)
  {
    SetLocalInt(oPC,"ORS_LEVELRET",1);

    //Set The Player to Previous Level
    int nCurLevel   = GetHitDice(oPC);
    int nCurXP      = GetXP(oPC);
    int nPreXP;

    switch(nCurLevel)
    {
      case  0: nPreXP = 0;break;
      case  1: nPreXP = 0;break;
      case  2: nPreXP = 1;break;
      case  3: nPreXP = 1000;break;
      case  4: nPreXP = 3000;break;
      case  5: nPreXP = 6000;break;
      case  6: nPreXP = 10000;break;
      case  7: nPreXP = 15000;break;
      case  8: nPreXP = 21000;break;
      case  9: nPreXP = 28000;break;
      case 10: nPreXP = 36000;break;
      case 11: nPreXP = 45000;break;
      case 12: nPreXP = 55000;break;
      case 13: nPreXP = 66000;break;
      case 14: nPreXP = 78000;break;
      case 15: nPreXP = 91000;break;
      case 16: nPreXP = 105000;break;
      case 17: nPreXP = 120000;break;
      case 18: nPreXP = 136000;break;
      case 19: nPreXP = 153000;break;
      case 20: nPreXP = 171000;break;
      case 21: nPreXP = 190000;break;
      case 22: nPreXP = 210000;break;
      case 23: nPreXP = 231000;break;
      case 24: nPreXP = 253000;break;
      case 25: nPreXP = 276000;break;
      case 26: nPreXP = 300000;break;
      case 27: nPreXP = 325000;break;
      case 28: nPreXP = 351000;break;
      case 29: nPreXP = 378000;break;
      case 30: nPreXP = 406000;break;
      case 31: nPreXP = 435000;break;
      case 32: nPreXP = 465000;break;
      case 33: nPreXP = 496000;break;
      case 34: nPreXP = 528000;break;
      case 35: nPreXP = 561000;break;
      case 36: nPreXP = 595000;break;
      case 37: nPreXP = 630000;break;
      case 38: nPreXP = 666000;break;
      case 39: nPreXP = 703000;break;
      case 40: nPreXP = 741000;break;
    }

    //Now Set How Much XP to Give Back
    int nRetXP = nCurXP - nPreXP;

    //Now we set the Previous XP
    SetXP(oPC, nPreXP);

    //Now Delay the Returned XP For Relevel
    DelayCommand(5.0,GiveXPToCreature(oPC,nRetXP));
    DelayCommand(5.1,SetLocalInt(oPC,"ORS_LEVELRET",0));
  }
}
