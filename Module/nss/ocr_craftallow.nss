////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Crafting Anvil Placeable Required
//  ocr_craftallow
//  by Don Anderson
//  dandersonru@msn.com
//
//  Used in Crafting Conversation
//
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC        = GetPCSpeaker();
  object oAnvil     = GetNearestObjectByTag("CraftingAnvil",oPC);
  object oStump     = GetNearestObjectByTag("CraftingStump",oPC);
  float fDist       = 2.0;

  int nNotAllow = TRUE;

  float fCheck = 10.0;
  float fAnvil = 10.0;
  float fStump = 10.0;

  if(GetIsObjectValid(oAnvil))
  {
    fAnvil = GetDistanceBetween(oPC, oAnvil);
  }

  if(GetIsObjectValid(oStump))
  {
    fStump = GetDistanceBetween(oPC, oStump);
  }

  if(fAnvil < fCheck) fCheck = fAnvil;
  if(fStump < fCheck) fCheck = fStump;

  if(fCheck <= fDist) nNotAllow = FALSE;

  return nNotAllow;
}
