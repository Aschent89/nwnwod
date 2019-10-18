/* Script Created By Rami_Ahmed */
void main()
{
  int nShopStartingPrice = 200000;
  // * This is the starting price for any shop throughout the module.

  int nMaxShopItems = 24;
  // * This is the maximum amount of items possible to store for the player.
  // ** Do not set this number too high - when opening the store the players will recieve some lag.

  int nSalesmanWage = 50;
  // * This is the wage (in gold pieces) that the salesmen will want for working 1 day (ingame)

  int nLongestNameAllowed = 32;
  // * This is the number of digits that shop names maximum may have.
  // ** Set to 0 or any negative integer to disable name-changing.

  /* Do not edit anything below */
  object oMod = GetModule();
  AssignCommand(oMod,SetLocalInt(oMod, "ShopStartPrice", nShopStartingPrice));
  AssignCommand(oMod,SetLocalInt(oMod, "ShopMaxItems", nMaxShopItems));
  AssignCommand(oMod,SetLocalInt(oMod, "ShopMinSalary", nSalesmanWage));
  AssignCommand(oMod,SetLocalInt(oMod, "ShopRuleMaxNam", nLongestNameAllowed));
}
