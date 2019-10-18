////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Soul Rune Bonus
//  ors_lifebonus
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this in the Module OnPlayeLevelUp Event
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void main()
{
  object oPC = GetPCLevellingUp();
  object oMod = GetModule();

  //Soul Rune System is not On
  int nPD = GetLocalInt(oMod,"PERMDEATH");
  if(nPD <= 0) return;

  int nLRet = GetLocalInt(oPC,"ORS_LEVELRET");
  if(nLRet > 0) return;

  int nLifeBonus = FALSE;
  int nCurLevel = GetHitDice(oPC);
  if(nCurLevel == 16) nLifeBonus = TRUE;
 // if(nCurLevel == 15) nLifeBonus = TRUE;
  if(nCurLevel == 22) nLifeBonus = TRUE;
//  if(nCurLevel == 20) nLifeBonus = TRUE;
  if(nCurLevel == 28) nLifeBonus = TRUE;
//  if(nCurLevel == 25) nLifeBonus = TRUE;
  if(nCurLevel == 34) nLifeBonus = TRUE;
//  if(nCurLevel == 30) nLifeBonus = TRUE;
  if(nCurLevel == 40) nLifeBonus = TRUE;
//  if(nCurLevel == 35) nLifeBonus = TRUE;
 // if(nCurLevel == 40) nLifeBonus = TRUE;
//  if(nCurLevel == 40) nLifeBonus = TRUE;

  if(nLifeBonus == TRUE)
  {
    //First Validate Quantity
    ORS_ValidateLifes(oPC);

    //Now Check for Maximum Soul Runes
    int nLives = GetLocalInt(oMod,"LIVES");
    string sLives = ORS_GetTotalLifes(oPC);
    if(sLives == IntToString(nLives))
    {
      SendMessageToPC(oPC,"You already have the maximum Lifes allowed.");
      return;
    }

    //Give a Soul Rune
    else
    {
      object oSoulRune = CreateItemOnObject("soulrune", oPC,1);
      SendMessageToPC(oPC,"One Soul Rune has been given to you at this level.");
    }
  }
}
