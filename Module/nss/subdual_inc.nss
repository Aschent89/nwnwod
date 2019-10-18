/*****************************************************************************
  PC Subdual Damage
  By Rocc
  Version 0.9
  October 26, 2002

  Allows for PC subdual in PvP combat.
******************************************************************************/

// Change these constants to set the maximum of 'knockout hits' that a PC can
// receive before moving to the next stage of unconsciousness.
// For example, if SUBDUE_WINDED = 3, a PC can receive 3 hits in a short period
// of time and remain winded. 4 hits will cause him to black out.
int SUBDUE_WINDED = 3;
int SUBDUE_BLACKOUT = 6;
int SUBDUE_KNOCKOUT = 9;
int SUBDUAL_MODE_FULL_DAMAGE=0;
int SUBDUAL_MODE_SUBDUAL=1;
int SUBDUAL_MODE_SPARRING=2;

// Main subdual check funciton. Call only in OnPlayerDeath and OnPlayerDying.
// Will return the degree of damage the player has incurred, or 0 if it was
// not subdual damage.
int CheckSubdual(object oPC);

// Only CheckSubdual is meant to be called, and then only from
// OnPlayerDeath and OnPlayerDying. The rest are internal functions.

void SetSubdualHealth(object oPC);
void SetSubdued(object oPC, int i);
void SubdualDrop(object oPC, int type=1);
void SubdualDecrease(object oPC, int lastValue);
int GetSubdual(object oPC);

int CheckSubdual(object oPC)
{
  int j=GetSubdual(oPC);
  if(j) {
    int i=GetLocalInt(oPC,"nSubdued"); i++;
    if ((j==SUBDUAL_MODE_SPARRING) && (i<=SUBDUE_WINDED+1)) i=1;
    SetLocalInt(oPC,"nSubdued",i);
    SetSubdualHealth(oPC);
    SetSubdued(oPC,i);
    return i;
  }
  return FALSE;
}

void SetSubdualHealth(object oPC) {
  if ((GetCurrentHitPoints(oPC))<-9)
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
  else if ((GetCurrentHitPoints(oPC))<1)
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(abs(GetCurrentHitPoints(oPC))+1),oPC);
}

void SetSubdued(object oPC,int i) {
  string sMes;
  float timeUnc, timeDazed;
  int dropType,moveDec,acDec;
  if (i<=SUBDUE_WINDED) {
    sMes="**Winded**";
    timeUnc=15.0; timeDazed=30.0;
    dropType=0; moveDec=20; acDec=2;
  } else if (i<=SUBDUE_BLACKOUT) {
    sMes="**Blacked out**";
    timeUnc=30.0; timeDazed=60.0;
    dropType=0; moveDec=35; acDec=5;
  } else if(i<=SUBDUE_KNOCKOUT) {
    sMes="**Knocked out**";
    timeUnc=45.0; timeDazed=120.0;
    dropType=0; moveDec=50; acDec=7;
  } else {
    sMes="**Concussion**";
    timeUnc=60.0; timeDazed=240.0;
    dropType=0; moveDec=75; acDec=10;
  }
  // Apply the subdual effects
  AssignCommand(oPC,ClearAllActions());
  AssignCommand(oPC,ActionSpeakString(sMes));
  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,timeUnc));
  AssignCommand(oPC,ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMovementSpeedDecrease(moveDec),oPC,timeDazed)));
  AssignCommand(oPC,ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectACDecrease(acDec),oPC,timeDazed)));
  AssignCommand(oPC,ActionDoCommand(SetCommandable(TRUE,oPC)));
  AssignCommand(oPC,SetCommandable(FALSE,oPC));
  DelayCommand(timeUnc+timeDazed,SubdualDecrease(oPC,i));
  if (dropType>0) SubdualDrop(oPC,dropType);
}

// Returns type of subdual.
// GetLastAttacker, GetGoingToBeAttackedBy, GetLastHostileActor
// seem to work correctly in an ondeath script for a PC.
// To be safe, check everything for a possible subdual attack.
// If there is an incorrect positive, the attacker can always hit
// the PC again.
int GetSubdual(object oPC) {
  int i=0;
  object oKiller=GetLastAttacker(oPC);
  if(GetIsObjectValid(oKiller))
    if((GetLocalInt(oKiller,"SUBDUAL"))&&(oKiller!=oPC))
      i=GetLocalInt(oKiller,"SUBDUAL");
  oKiller=GetGoingToBeAttackedBy(oPC);
  if(GetIsObjectValid(oKiller))
    if((GetLocalInt(oKiller,"SUBDUAL"))&&(oKiller!=oPC))
      i=GetLocalInt(oKiller,"SUBDUAL");
  oKiller=GetLastDamager();
  if(GetIsObjectValid(oKiller))
    if((GetLocalInt(oKiller,"SUBDUAL"))&&(oKiller!=oPC))
      i=GetLocalInt(oKiller,"SUBDUAL");
  oKiller=GetLastKiller();
  if(GetIsObjectValid(oKiller))
    if((GetLocalInt(oKiller,"SUBDUAL"))&&(oKiller!=oPC))
      i=GetLocalInt(oKiller,"SUBDUAL");
  oKiller=GetLastHostileActor(oPC);
  if(GetIsObjectValid(oKiller))
    if((GetLocalInt(oKiller,"SUBDUAL"))&&(oKiller!=oPC))
      i=GetLocalInt(oKiller,"SUBDUAL");
  oKiller=GetLastSpellCaster();
  if(GetIsObjectValid(oKiller))
    if((GetLocalInt(oKiller,"SUBDUAL"))&&(oKiller!=oPC))
      i=GetLocalInt(oKiller,"SUBDUAL");
  return i;

}

void SubdualDecrease(object oPC, int lastValue) {
  if (GetLocalInt(oPC,"nSubdued")==lastValue)
    SetLocalInt(oPC,"nSubdued",0);
}

void strip_item(object oPlayer, object oBag, object oEquip) {
  if(GetIsObjectValid(oEquip)) AssignCommand(oBag, ActionTakeItem(oEquip, oPlayer));
}

void SubdualDrop(object oPC, int type=1) {
  if (type==0) return;
  object oItemBag;
  string sID=GetName(oPC)+GetPCPublicCDKey(oPC);
  vector vVec=GetPositionFromLocation(GetLocation(oPC));
  vVec.x+=0.6;
  location lLoc=Location(GetAreaFromLocation(GetLocation(oPC)),vVec,0.0);
  oItemBag=CreateObject(OBJECT_TYPE_PLACEABLE, "subdualbag", lLoc);
  SetLocalString(oItemBag,"Name",GetName(oPC));
  int nAmtGold=GetGold(oPC);
  object oBag;
  if(nAmtGold) {
      oBag=CreateItemOnObject("bagofgold",oItemBag);
      SetLocalInt(oBag,"AmtGold",nAmtGold);
      AssignCommand(oItemBag,TakeGoldFromCreature(nAmtGold,oPC,TRUE));
  }
  if (type==3) {
    strip_item(oPC, oItemBag, GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC));
    strip_item(oPC, oItemBag, GetItemInSlot(INVENTORY_SLOT_ARMS, oPC));
    strip_item(oPC, oItemBag, GetItemInSlot(INVENTORY_SLOT_BELT, oPC));
    strip_item(oPC, oItemBag, GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC));
    strip_item(oPC, oItemBag, GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC));
    strip_item(oPC, oItemBag, GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC));
    strip_item(oPC, oItemBag, GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));
    strip_item(oPC, oItemBag, GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC));
    strip_item(oPC, oItemBag, GetItemInSlot(INVENTORY_SLOT_HEAD, oPC));
    strip_item(oPC, oItemBag, GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC));
    strip_item(oPC, oItemBag, GetItemInSlot(INVENTORY_SLOT_NECK, oPC));
    strip_item(oPC, oItemBag, GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC));
  }

// Drop inventory items
  if(type>=2) {
    strip_item(oPC, oItemBag, GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
    strip_item(oPC, oItemBag, GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC));
    object oEquip = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oEquip)) {
// Don't drop HCR, ATS, or SLA items
      if ( (GetTag(oEquip)=="hc_palbadgecour")
            || (GetTag(oEquip)=="hc_paladinsymb")
            || (GetTag(oEquip)=="searchtool")
            || (GetTag(oEquip)=="TrackerTool")
            || (GetTag(oEquip)=="EmoteWand")
            || (GetTag(oEquip)=="fuguerobe")) {
        oEquip = GetNextItemInInventory(oPC);
        continue;
      }
      if ((GetStringLeft(GetTag(oEquip), 9) == "ATS_TOKEN" ||
            (FindSubString(GetTag(oEquip), "_NOD") > 0 || FindSubString(GetTag(oEquip), "NODROP") > 0))&&(GetIsPC(oPC))) {
        oEquip = GetNextItemInInventory(oPC);
        continue;
      }
      if ( GetStringLeft(GetTag(oEquip),7)=="sei_sla" ) {
        oEquip = GetNextItemInInventory(oPC);
        continue;
      }
      AssignCommand(oItemBag, ActionTakeItem(oEquip, oPC));
      oEquip = GetNextItemInInventory(oPC);
    }
  }

}
