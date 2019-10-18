////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Allegiance System
//  ors_ally_sign
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void main()
{
  object oPC    = GetLastUsedBy();
  object oAlign = OBJECT_SELF;
  string sName  = GetName(oAlign);
  string sAlign = GetTag(oAlign);
  object oMod   = GetModule();

  effect eFX1   = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
  effect eFX2   = EffectVisualEffect(VFX_IMP_DEATH);

  if(GetIsDM(oPC) == TRUE) return;

  string sDB = ORS_GetDBString();
  int nORS_ALIGN = NBDE_GetCampaignInt(sDB, "ORS_ALIGN", oPC);
  if(nORS_ALIGN > 0)
  {
    SpeakString("You have already chosen your alliegiance and can not do so again.");
    return;
  }

  //Compare Player Race with Sign Race
  int nRace = GetRacialType(oPC);

  //Alignment Skin to Create
  string sResRef = GetLocalString(oAlign,"ORS_RESREF");

  //Races Available (Will be 1)
  int nORS_DWARF = GetLocalInt(oAlign,"ORS_DWARF");
  int nORS_ELF = GetLocalInt(oAlign,"ORS_ELF");
  int nORS_HALFELF = GetLocalInt(oAlign,"ORS_HALFELF");
  int nORS_HALFLING = GetLocalInt(oAlign,"ORS_HALFLING");
  int nORS_HUMAN = GetLocalInt(oAlign,"ORS_HUMAN");
  int nORS_GNOME = GetLocalInt(oAlign,"ORS_GNOME");
  int nORS_HALFORC = GetLocalInt(oAlign,"ORS_HALFORC");

  //Classes Available (Only Base Classes Needed)
  int nORS_BARBARIAN = GetLocalInt(oAlign,"ORS_BARBARIAN");
  int nORS_BARD = GetLocalInt(oAlign,"ORS_BARD");
  int nORS_CLERIC = GetLocalInt(oAlign,"ORS_CLERIC");
  int nORS_DRUID = GetLocalInt(oAlign,"ORS_DRUID");
  int nORS_FIGHTER = GetLocalInt(oAlign,"ORS_FIGHTER");
  int nORS_MONK = GetLocalInt(oAlign,"ORS_MONK");
  int nORS_PALADIN = GetLocalInt(oAlign,"ORS_PALADIN");
  int nORS_RANGER = GetLocalInt(oAlign,"ORS_RANGER");
  int nORS_ROGUE = GetLocalInt(oAlign,"ORS_ROGUE");
  int nORS_SORCERER = GetLocalInt(oAlign,"ORS_SORCERER");
  int nORS_WIZARD = GetLocalInt(oAlign,"ORS_WIZARD");

  //Alignment
  int nORS_GOOD = GetLocalInt(oAlign,"ORS_GOOD");
  int nORS_NEUTRAL = GetLocalInt(oAlign,"ORS_NEUTRAL");
  int nORS_EVIL = GetLocalInt(oAlign,"ORS_EVIL");

  //Law/Chaos
  int nORS_ALIGN_LAW = GetLocalInt(oAlign,"ORS_ALIGN_LAW");
  int nORS_ALIGN_NEUTRAL = GetLocalInt(oAlign,"ORS_ALIGN_NEUTRAL");
  int nORS_ALIGN_CHAOS = GetLocalInt(oAlign,"ORS_ALIGN_CHAOS");

/******************************************************************************/
//:: CHECK PLAYER RACIAL PROPERTIES

int nRaceOK = FALSE;
int nAlignOK = FALSE;
int nClassOK = FALSE;

  //Dwarf
  if(nRace == RACIAL_TYPE_DWARF)
  {
    if(nORS_DWARF) nRaceOK = TRUE;
  }

  //Elf
  if((nRace == RACIAL_TYPE_ELF))
  {
    if(nORS_ELF) nRaceOK = TRUE;
  }

  //Half Elf
  if(nRace == RACIAL_TYPE_HALFELF)
  {
    if(nORS_HALFELF) nRaceOK = TRUE;
  }

  //Halfling
  if(nRace == RACIAL_TYPE_HALFLING)
  {
    if(nORS_HALFELF) nRaceOK = TRUE;
  }

  //Human
  if(nRace == RACIAL_TYPE_HUMAN)
  {
    if(nORS_HALFELF) nRaceOK = TRUE;
  }

  //Gnome
  if(nRace == RACIAL_TYPE_GNOME)
  {
    if(nORS_HALFELF) nRaceOK = TRUE;
  }

  //Half Orc
  if(nRace == RACIAL_TYPE_HALFORC)
  {
    if(nORS_HALFELF) nRaceOK = TRUE;
  }

  //Not the right Racial Properties
  if(nRaceOK == FALSE)
  {
    string sRace = "You do not have the proper Racial Properties for this Allegiance Sign. Please choose the right sign.";
    ORS_FloatColorString(oPC, sRace, RED);
    return;
  }

  //Good Alignment
  if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
  {
    if(nORS_GOOD) nAlignOK = TRUE;
  }

  //Neutral Alignment
  if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
  {
    if(nORS_NEUTRAL) nAlignOK = TRUE;
  }

  //Evil Alignment
  if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
  {
    if(nORS_EVIL) nAlignOK = TRUE;
  }

  //Law Alignment
  if(GetAlignmentLawChaos(oPC) == ALIGNMENT_LAWFUL)
  {
    if(nORS_ALIGN_LAW) nAlignOK = TRUE;
  }

  //Neutral Alignment
  if(GetAlignmentLawChaos(oPC) == ALIGNMENT_NEUTRAL)
  {
    if(nORS_ALIGN_NEUTRAL) nAlignOK = TRUE;
  }

  //Chaotic Alignment
  if(GetAlignmentLawChaos(oPC) == ALIGNMENT_CHAOTIC)
  {
    if(nORS_ALIGN_CHAOS) nAlignOK = TRUE;
  }

  //Not the right Racial Properties
  if(nAlignOK == FALSE)
  {
    string sAlignOK = "You are not the proper Alignment for this Allegiance Sign. Please choose the right sign.";
    ORS_FloatColorString(oPC, sAlignOK, RED);
    return;
  }


  //Barbarian
  if(GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC) > 0)
  {
    if(nORS_BARBARIAN) nClassOK = TRUE;
  }

  //Bard
  if(GetLevelByClass(CLASS_TYPE_BARD,oPC) > 0)
  {
    if(nORS_BARD) nClassOK = TRUE;
  }

  //Cleric
  if(GetLevelByClass(CLASS_TYPE_CLERIC,oPC) > 0)
  {
    if(nORS_CLERIC) nClassOK = TRUE;
  }

  //Druid
  if(GetLevelByClass(CLASS_TYPE_DRUID,oPC) > 0)
  {
    if(nORS_DRUID) nClassOK = TRUE;
  }

  //Fighter
  if(GetLevelByClass(CLASS_TYPE_FIGHTER,oPC) > 0)
  {
    if(nORS_FIGHTER) nClassOK = TRUE;
  }

  //Monk
  if(GetLevelByClass(CLASS_TYPE_MONK,oPC) > 0)
  {
    if(nORS_MONK) nClassOK = TRUE;
  }

  //Paladin
  if(GetLevelByClass(CLASS_TYPE_PALADIN,oPC) > 0)
  {
    if(nORS_PALADIN) nClassOK = TRUE;
  }

  //Ranger
  if(GetLevelByClass(CLASS_TYPE_RANGER,oPC) > 0)
  {
    if(nORS_RANGER) nClassOK = TRUE;
  }

  //Rogue
  if(GetLevelByClass(CLASS_TYPE_ROGUE,oPC) > 0)
  {
    if(nORS_ROGUE) nClassOK = TRUE;
  }

  //Sorcerer
  if(GetLevelByClass(CLASS_TYPE_SORCERER,oPC) > 0)
  {
    if(nORS_SORCERER) nClassOK = TRUE;
  }

  //Wizard
  if(GetLevelByClass(CLASS_TYPE_WIZARD,oPC) > 0)
  {
    if(nORS_WIZARD) nClassOK = TRUE;
  }

  //Not the right Racial Properties
  if(nClassOK == FALSE)
  {
    string sClassOK = "You are not the proper Class for this Allegiance Sign. Please choose the right sign.";
    ORS_FloatColorString(oPC, sClassOK, RED);
    return;
  }

//:: CHECK PLAYER RACIAL PROPERTIES
/******************************************************************************/

  //Destroy Allegiance Skin
  DestroyObject(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC), 0.0);

  //Now Give a PC Property Skin
  object oNSkin = CreateItemOnObject(sResRef,oPC);
  AssignCommand(oPC,ActionEquipItem(oNSkin,INVENTORY_SLOT_CARMOUR));
  SetLocalObject(oPC,"oX3_Skin",oNSkin);

  //Now Align the Player
  SetSubRace(oPC,sName);
  NBDE_SetCampaignInt(sDB,"ORS_ALIGN",1,oPC);
  NBDE_SetCampaignString(sDB,"ORS_ALIGN_SKIN",sResRef,oPC);
  string sChosen = "You have now chosen your Racial Properties. Fair journies "+GetName(oPC);
  ORS_FloatColorString(oPC, sChosen, GRAY);
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX1, oPC);
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eFX2, oPC);
}
