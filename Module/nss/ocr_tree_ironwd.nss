////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Harvesting Trees
//  ocr_tree_ironwd
//  By:Don Anderson
//  danderonsur@msn.com
//
//  This is placed in the OnDamaged Event of a tree
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC  = GetLastDamager();
    object oMod = GetModule();

    int nReq    = GetLocalInt(oMod,"TREEIRONW");//See cr_mod_onload
    int nGive   = 0;
    int nMaxHP  = GetMaxHitPoints(oSelf);
    int nCurHP  = GetCurrentHitPoints(oSelf);
    if(GetLocalInt(oSelf, "OLDHP") == 0) SetLocalInt(oSelf,"OLDHP",nMaxHP);
    if(GetLocalInt(oSelf, "NEWHP") == 0) SetLocalInt(oSelf,"NEWHP",nCurHP);
    int nOldHP  = GetLocalInt(oSelf, "OLDHP");
    int nTally  = GetLocalInt(oSelf, "TALLY");

    string sAxe = "Please equip the Woodmans Axe or Light Wood Axe to take this tree down.";
    string sTree = "IronWood";
    string sDrop = "A piece of wood has fallen to the ground."; // Tree drop text
    string sDropx2 = "Two pieces of wood have fallen to the ground."; // Tree double drop text
    string sFail = "Keep swinging. Lumbering is tough work."; // Tree failed text
    string sWA = GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));

    //This is where we decide when to give chunks of ore
    SetLocalInt(oSelf,"OLDHP",nCurHP);
    nTally = nTally + (nOldHP - nCurHP);

    if(nTally >= nReq)
    {
      nGive = 1;
      SetLocalInt(oSelf,"TALLY",0);
    }
    else if(nTally < nReq)
    {
      nGive = 0;
      SetLocalInt(oSelf,"TALLY",nTally);
    }

    //Give the Player information about the progress
    string sTally = IntToString(nTally);
    string sReq = IntToString(nReq);
    SendMessageToPC(oPC,"Tallied damage is: " +sTally+ " of the required: " +sReq );

    if (!GetIsPC(oPC)) return;

    // A check to see if a Woodmans Axe is equiped in the RIGHT hand
    if (sWA == "WoodmansAxe")
    {
      if(nGive == 1)
      {
        SendMessageToPC(oPC, sDropx2);
        CreateObject(OBJECT_TYPE_ITEM, sTree, GetLocation(oPC));
        CreateObject(OBJECT_TYPE_ITEM, sTree, GetLocation(oPC));
      }
      else
      {
        SendMessageToPC(oPC, sFail);
      }
    }
    // A check to see if a Light Wood Axe is equiped in the RIGHT hand
    else if (sWA == "LightWoodAxe")
    {
      if(nGive == 1)
      {
        SendMessageToPC(oPC, sDrop);
        CreateObject(OBJECT_TYPE_ITEM, sTree, GetLocation(oPC));
      }
      else
      {
        SendMessageToPC(oPC, sFail);
      }
    }
    else
    {
      SendMessageToPC( oPC, sAxe);
      return;
    }
}

