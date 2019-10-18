////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Woodworking Table
//  ocr_od_wood
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is placed in the OnDamaged Event of the Crafting Woodworking Table
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

void main()
{
    object oSelf = OBJECT_SELF;
    string sName = GetName(oSelf);
    object oPC  = GetLastDamager();
    object oMod = GetModule();

    if(!GetIsPC(oPC)) return;

    //Damage Required
    int nReq = 50;

    int nGive   = 0;
    int nMaxHP  = GetMaxHitPoints(oSelf);
    int nCurHP  = GetCurrentHitPoints(oSelf);
    if(GetLocalInt(oSelf, "OLDHP") == 0) SetLocalInt(oSelf,"OLDHP",nMaxHP);
    if(GetLocalInt(oSelf, "NEWHP") == 0) SetLocalInt(oSelf,"NEWHP",nCurHP);
    int nOldHP  = GetLocalInt(oSelf, "OLDHP");
    int nTally  = GetLocalInt(oSelf, "TALLY");

    //Type of Item Set from ORM
    string sItem = GetLocalString(oPC,"OCR_WOOD");

    string sTool = "Please equip the Carving Knife to work at the Woodworking Table.";
    string sSuccess = "Well done and nice work!";
    string sFail = "Keep carving. It is coming along nicely!";
    string sMP = GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));

    //This is where we decide when to give something
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

    // A check to see if the Proper Tool is equiped in the RIGHT hand
    if(sMP == "CarvingKnife")
    {
      if(nGive == 1)
      {
        SendMessageToPC(oPC, sSuccess);
        CreateObject(OBJECT_TYPE_ITEM, sItem, GetLocation(oPC));
        AssignCommand(oPC,ClearAllActions(TRUE));
        DelayCommand(1.0, AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED,1.0,3.0)));
        DelayCommand(4.5, AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1,1.0)));
      }
      else
      {
        SendMessageToPC(oPC, sFail);
      }
    }
    else
    {
      SendMessageToPC( oPC, sTool);
      return;
    }
}
