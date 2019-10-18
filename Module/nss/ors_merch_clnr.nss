////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Merchant Cleaner
//  ors_merch_clnr
//  by Don Anderson
//  dandersonru@msn.com
//
//  This Cleans the Merchant of Duplicates when Opened
//  This goes in the OnOpen Event of a Merchant
//
//  Credits to Adrian for the Original Script (Modified for ResRef Use and ORSv4)
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oMerch = OBJECT_SELF;
  object oMod = GetModule();
  object oItem = GetFirstItemInInventory();
  string sItemResRef;
  int nLoop = 0;

  //Module Configs
  int nMERCHCLEAN = GetLocalInt(oMod,"MERCHCLEAN");
  if(nMERCHCLEAN == 0) return;
  int nMERCHREPNUM = GetLocalInt(oMod,"MERCHREPNUM");

  //Delete More than Configured Amount of Replicas
  while(GetIsObjectValid(oItem))
  {
    sItemResRef = GetResRef(oItem);
    nLoop = GetLocalInt(oMerch, "ORS_" + sItemResRef);

    if(nLoop >= nMERCHREPNUM)
    {
      DestroyObject(oItem);
    }
    else
    {
      ++nLoop;
      SetLocalInt(oMerch, "ORS_" + sItemResRef ,nLoop);
    }

    oItem = GetNextItemInInventory();
  }

  //Reset Merchant Variables
  oItem = GetFirstItemInInventory();
  while(GetIsObjectValid(oItem))
  {
    SetLocalInt(OBJECT_SELF, "ORS_" + GetResRef(oItem), 0);
    oItem = GetNextItemInInventory();
  }
}
