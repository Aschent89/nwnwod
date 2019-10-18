////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Mining Ore with Ore Pick
//  ocr_od_ore
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is placed in the OnDamaged Event of a Boulder or Stone
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

    //Type of Ore
    string sOre = GetLocalString(oSelf,"OCR_ORE_RESREF");

    string sOreTool = "Please equip the Proper Tool to Mine this Ore.";
    string sDrop = "A chunk of Ore has fallen to the ground.";
    string sDropx2 = "Two chunks of Ore have fallen to the ground.";
    string sFail = "Keep trying. Mining Ore is tough work.";
    string sMP = GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));

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

    // A check to see if a Proper Mining Tool is Equipped in the RIGHT hand
    int nTool = GetLocalInt(oSelf,sMP);
    if(nTool == 1)
    {
      if(nGive == 1)
      {
        if(d2(1) == 1 && sMP == "MiningPick")
        {
          CreateObject(OBJECT_TYPE_ITEM, sOre, GetLocation(oPC));
          CreateObject(OBJECT_TYPE_ITEM, sOre, GetLocation(oPC));
          SendMessageToPC(oPC, sDropx2);
        }
        else
        {
          CreateObject(OBJECT_TYPE_ITEM, sOre, GetLocation(oPC));
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
      SendMessageToPC( oPC, sOreTool);
      SetLocalInt(oSelf,"TALLY",0);
      AssignCommand(oPC,ClearAllActions(TRUE));
    }

    //Now check for Mining Tool Breakage 1% Chance
    if(d100(1) < 2)
    {
      DestroyObject(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
      SendMessageToPC(oPC,"Your "+ GetName(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC))+" has broken and is usless. Have to purchase another.");
    }
}

