////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Harvesting Trees
//  ocr_od_tree
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is placed in the OnDamaged Event of a tree
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC  = GetLastDamager();
    object oMod = GetModule();
    string sTag = GetTag(oSelf);

    //Damage Required
    int nReq    = GetLocalInt(oSelf,"OCR_DAMAGE");
    int nMinReq    = GetLocalInt(oMod,"OCR_DAMAGE");
    if(nReq < nMinReq) nReq = nMinReq;

    int nGive   = 0;
    int nMaxHP  = GetMaxHitPoints(oSelf);
    int nCurHP  = GetCurrentHitPoints(oSelf);
    if(GetLocalInt(oSelf, "OLDHP") == 0) SetLocalInt(oSelf,"OLDHP",nMaxHP);
    if(GetLocalInt(oSelf, "NEWHP") == 0) SetLocalInt(oSelf,"NEWHP",nCurHP);
    int nOldHP  = GetLocalInt(oSelf, "OLDHP");
    int nTally  = GetLocalInt(oSelf, "TALLY");

    //Type of Wood
    string sTree = GetLocalString(oSelf,"OCR_WOOD_RESREF");

    string sAxe = "Please equip the Proper Woodmans Tool to take this tree down.";
    string sDrop = "A piece of wood has fallen to the ground.";
    string sDropx2 = "Two pieces of wood have fallen to the ground.";
    string sFail = "Keep swinging. Lumbering is tough work.";
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

    // A check to see if a Proper Wood Tool is Equipped in the RIGHT hand
    int nTool = GetLocalInt(oSelf,sWA);
    if(nTool == 1)
    {
      if(nGive == 1)
      {
        if(d2(1) == 1 && sWA == "WoodmansAxe")
        {
          CreateObject(OBJECT_TYPE_ITEM, sTree, GetLocation(oPC));
          CreateObject(OBJECT_TYPE_ITEM, sTree, GetLocation(oPC));
          SendMessageToPC(oPC, sDropx2);
        }
        else
        {
          CreateObject(OBJECT_TYPE_ITEM, sTree, GetLocation(oPC));
          SendMessageToPC(oPC, sDrop);
        }
      }
      else
      {
        SendMessageToPC(oPC, sFail);
      }
    }
    else
    {
      SendMessageToPC( oPC, sAxe);
      SetLocalInt(oSelf,"TALLY",0);
      AssignCommand(oPC,ClearAllActions(TRUE));
    }

    //Now check for Wood Tool Breakage 1% Chance
    if(d100(1) < 2)
    {
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
      SendMessageToPC(oPC,"Your "+ GetName(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC))+" has broken and is usless. Have to purchase another.");
    }
}

