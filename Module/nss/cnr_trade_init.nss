/////////////////////////////////////////////////////////
//
//  Craftable Natural Resources (CNR) by Festyx
//
//  Name:  cnr_trade_init
//
//  Desc:  Tradeskill recipe initialization. This script
//         is executed from "cnr_recipe_init".
//
//  Author: David Bobeck 25Jan03
//
/////////////////////////////////////////////////////////
#include "cnr_recipe_utils"

void main()
{
  PrintString("cnr_trade_init");

  // Configure the XP required to achieve each tradeskill level
  object oModule = GetModule();
  SetLocalInt(oModule, "CnrTradeXPLevel1", 0);
  SetLocalInt(oModule, "CnrTradeXPLevel2", 100);
  SetLocalInt(oModule, "CnrTradeXPLevel3", 300);
  SetLocalInt(oModule, "CnrTradeXPLevel4", 600);
  SetLocalInt(oModule, "CnrTradeXPLevel5", 1000);
  SetLocalInt(oModule, "CnrTradeXPLevel6", 1500);
  SetLocalInt(oModule, "CnrTradeXPLevel7", 2100);
  SetLocalInt(oModule, "CnrTradeXPLevel8", 2800);
  SetLocalInt(oModule, "CnrTradeXPLevel9", 3600);
  SetLocalInt(oModule, "CnrTradeXPLevel10", 4500);
  SetLocalInt(oModule, "CnrTradeXPLevel11", 6500);
  SetLocalInt(oModule, "CnrTradeXPLevel12", 7600);
  SetLocalInt(oModule, "CnrTradeXPLevel13", 8800);
  SetLocalInt(oModule, "CnrTradeXPLevel14", 10100);
  SetLocalInt(oModule, "CnrTradeXPLevel15", 13500);
  SetLocalInt(oModule, "CnrTradeXPLevel16", 17100);
  SetLocalInt(oModule, "CnrTradeXPLevel17", 20800);
  SetLocalInt(oModule, "CnrTradeXPLevel18", 25600);
  SetLocalInt(oModule, "CnrTradeXPLevel19", 29500);
  SetLocalInt(oModule, "CnrTradeXPLevel20", 40000);

  CnrAddTradeskill(CNR_TRADESKILL_SMELTING, "Smelting");
  CnrAddTradeskill(CNR_TRADESKILL_WEAPON_CRAFTING, "Weapon Crafting");
  CnrAddTradeskill(CNR_TRADESKILL_ARMOR_CRAFTING, "Armor Crafting");
  CnrAddTradeskill(CNR_TRADESKILL_ALCHEMY, "Alchemy");
  CnrAddTradeskill(CNR_TRADESKILL_SCRIBING, "Scribing");
  CnrAddTradeskill(CNR_TRADESKILL_TINKERING, "Tinkering");
  CnrAddTradeskill(CNR_TRADESKILL_WOOD_CRAFTING, "Wood Crafting"); // includes BOWERING, FLETCHING, CARPENTRY
  CnrAddTradeskill(CNR_TRADESKILL_ENCHANTING, "Enchanting");   // includes IMBUING
  CnrAddTradeskill(CNR_TRADESKILL_GEM_CRAFTING, "Gem Crafting");
  CnrAddTradeskill(CNR_TRADESKILL_TAILORING, "Tailoring");
  CnrAddTradeskill(CNR_TRADESKILL_FOOD_CRAFTING, "Food Crafting");

  // Module builders: You should add your trade skills to the
  // file "user_trade_init" so that future versions of
  // CNR don't over-write your work.

}
