/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnrAnvilPublic
//
//  Desc:  Recipe initialization.
//
//  Author: David Bobeck 15May03
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"

////////////////////////////////////////////////////////////////////////
// NOTE: This file has been formatted to be compatible with RecipeMaker.
////////////////////////////////////////////////////////////////////////

//void ProcessMenuWeaponsCopp(string sMenuWeaponsCopp);
//void ProcessMenuWeaponsBron(string sMenuWeaponsBron);
void ProcessMenuWeaponsSilv(string sMenuWeaponsSilv);

void main()
{
  PrintString("cnrAnvilSilver init");

  /////////////////////////////////////////////////////////
  // CNR recipes made by cnrAnvilPublic
  /////////////////////////////////////////////////////////

  CnrRecipeSetDevicePreCraftingScript("cnrAnvilSilver", "cnr_anvil_anim");
  CnrRecipeSetDeviceEquippedTool("cnrAnvilSilver", "cnrSmithsHammer", CNR_FLOAT_SMITH_HAMMER_BREAKAGE_PERCENTAGE);
  CnrRecipeSetDeviceTradeskillType("cnrAnvilSilver", CNR_TRADESKILL_WEAPON_CRAFTING);

//  string sMenuWeaponsCopp = CnrRecipeAddSubMenu("cnrAnvilPublic", "Copper Weapons");
//  string sMenuWeaponsBron = CnrRecipeAddSubMenu("cnrAnvilPublic", "Bronze Weapons");
  string sMenuWeaponsSilv = CnrRecipeAddSubMenu("cnrAnvilSilver", "Silver Weapons");

//  CnrIncrementStackCount(OBJECT_SELF);
//  AssignCommand(OBJECT_SELF, ProcessMenuWeaponsCopp(sMenuWeaponsCopp));

//  CnrIncrementStackCount(OBJECT_SELF);
//  AssignCommand(OBJECT_SELF, ProcessMenuWeaponsBron(sMenuWeaponsBron));

  CnrIncrementStackCount(OBJECT_SELF);
  AssignCommand(OBJECT_SELF, ProcessMenuWeaponsSilv(sMenuWeaponsSilv));
}

void ProcessMenuWeaponsSilv(string sMenuWeaponsSilv)
{
  string sKeyToRecipe;

  string sMenuSilvAmmo = CnrRecipeAddSubMenu(sMenuWeaponsSilv, "Silver Ammo");
  string sMenuSilvAxes = CnrRecipeAddSubMenu(sMenuWeaponsSilv, "Silver Axes");
  string sMenuSilvBladed = CnrRecipeAddSubMenu(sMenuWeaponsSilv, "Silver Bladed");
  string sMenuSilvBlunts = CnrRecipeAddSubMenu(sMenuWeaponsSilv, "Silver Blunts");
  string sMenuSilvExotic = CnrRecipeAddSubMenu(sMenuWeaponsSilv, "Silver Exotic");
  string sMenuSilvDouble = CnrRecipeAddSubMenu(sMenuWeaponsSilv, "Silver Double-Sided");
  string sMenuSilvPolearms = CnrRecipeAddSubMenu(sMenuWeaponsSilv, "Silver Polearms");
  string sMenuSilvThrowing = CnrRecipeAddSubMenu(sMenuWeaponsSilv, "Silver Throwing");

  /////////////// Iron Weapons ///////////////

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvAmmo, "Silver Bullet", "silverbullet", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldSmall", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 12);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvThrowing, "Silver Dart", "silverdart", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldSmall", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrFeatherRaven", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 15);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledCopp", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvThrowing, "Silver Throwing Axes", "silvertaxe", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldSmall", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 15);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvThrowing, "Silver Shuriken", "silvershuriken", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldSmall", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 15);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvExotic, "Silver Kukri", "silverkukri", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldSmall", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 15);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvExotic, "Silver Sickle", "silversickle", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldSmall", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 15);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvPolearms, "Silver Spear", "silverspear", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldSmall", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 15);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvBladed, "Silver Dagger", "silverdagger", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldSmall", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 15);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvBlunts, "Light Silver Hammer", "silverlthammer", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldSmall", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 15);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 120, 120);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvExotic, "Silver Kama", "silverkama", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldSmall", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvAxes, "Silver Handaxe", "silverhandaxe", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldSmall", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvBlunts, "Light Silver Flail", "silverltflail", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldSmall", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvPolearms, "Silver Scythe", "silverscythe", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldSmall", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvBladed, "Silver Scimitar", "silverscimitar", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 4);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldMedium", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvBlunts, "Silver Mace", "silvermace", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 4);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldMedium", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvBlunts, "Silver Morningstar", "silvermstar", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 4);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldMedium", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 16);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 130, 130);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvPolearms, "Silver Halberd", "silverhalberd", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 4);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldMedium", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvBladed, "Silver Shortsword", "silvershsword", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 4);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 2);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldMedium", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 1);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvAxes, "Silver Battleaxe", "silverbattleaxe", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 5);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldMedium", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvBlunts, "Silver Warhammer", "silverwarhammer", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 5);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldMedium", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvBladed, "Silver Rapier", "silverrapier", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 5);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldLarge", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvBlunts, "Heavy Silver Flail", "silverhyflail", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 5);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldLarge", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvExotic, "Silver Katana", "silverkatana", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 5);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldLarge", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvDouble, "Silver Dire Mace", "silverdiremace", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 6);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldLarge", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvBladed, "Silver Longsword", "silverlgsword", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 6);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldLarge", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvAxes, "Silver Greataxe", "silvergreataxe", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 6);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldLarge", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvDouble, "Silver Double Axe", "silverdoubleaxe", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 6);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldLarge", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvBladed, "Silver Bastard Sword", "silverbasword", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 6);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldLarge", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvDouble, "Silver Two-Bladed Sword", "silverdsword", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 6);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldLarge", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrShaftMahog", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  sKeyToRecipe = CnrRecipeCreateRecipe(sMenuSilvBladed, "Silver Greatsword", "silvergrsword", 1);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotIron", 6);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrIngotSilv", 3);
  CnrRecipeAddComponent(sKeyToRecipe, "cnrMoldLarge", 1);
  CnrRecipeSetRecipeLevel(sKeyToRecipe, 17);
  CnrRecipeSetRecipeXP(sKeyToRecipe, 140, 140);
  CnrRecipeSetRecipeBiproduct(sKeyToRecipe, "cnrMangledIron", 0, 2);
  CnrRecipeSetRecipeAbilityPercentages(sKeyToRecipe, 70, 30, 0, 0, 0, 0);

  CnrDecrementStackCount(OBJECT_SELF);
}

