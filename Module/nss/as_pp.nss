//as_pp
//AmanShadar's PickPocket Tweak script
//Being able to jack someone's primary weapon does not make any sense,
//nor does being able to jack something that weighs 50lbs.
//stuff like that does not go unoticed.
//so Here is a scrpit that will prevent items over a certain weight from being pickpocketable.
//Place this line in your OnAquireItem script.
//This will run when a character first enters and mark everything over a certain
//weight as non-pickpocketable as well as when new items are aquired
//  ExecuteScript("as_pp", GetModule());
#include "x2_inc_switches"
const int AS_MAX_WEIGHT_STOLEN = 15;   //15 = 1.5 pounds, NWN uses tenths of a pound and returns integers only
const int AS_TAKE_GOLD_INSTEAD = TRUE; //take gold value instead of heavy item? Won't take more than victim has.
//SetPickpocketableFlag(oItem, 0);
void main()
{
    switch(GetUserDefinedItemEventNumber())
    {
        case X2_ITEM_EVENT_ACQUIRE:
        {   // The item was just acquired (picked up, purchased, stolen, etc).
            object oNewOwner = GetModuleItemAcquiredBy();
            object oItem = GetModuleItemAcquired();
            object oOldOwner = GetModuleItemAcquiredFrom();
            int iPP;
            if(!GetIsObjectValid(oNewOwner) || !GetIsObjectValid(oItem))
            {
                SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_CONTINUE);
                return;
            }
            if(!GetIsObjectValid(oOldOwner)) SetStolenFlag(oItem, FALSE);
            if(GetPickpocketableFlag(oItem)==FALSE) return; //already non-pickpocketable
            int iWeight = GetWeight(oItem);
            if(iWeight > AS_MAX_WEIGHT_STOLEN)
            {
                SetPickpocketableFlag(oItem, FALSE);
                iPP = FALSE;
            }
            else iPP = TRUE;
            if(!GetIsObjectValid(oOldOwner)) return;
            //now for checking for pp from npc, since they don't get these scripts run on spawn.
            int iStolen = GetStolenFlag(oItem);
            if(iStolen && !iPP)
            {
                CopyItem(oItem, oOldOwner, TRUE);
                if(AS_TAKE_GOLD_INSTEAD)
                {
                    int iGold = GetGoldPieceValue(oItem);
                    int iOldGold = GetGold(oOldOwner);
                    int iReward = (iOldGold < iGold ? iOldGold : iGold);
                    TakeGoldFromCreature(iReward, oOldOwner, TRUE);
                    GiveGoldToCreature(oNewOwner, iReward);
                }
                DestroyObject(oItem);
            }
        }
        SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_END);
        return;
    }
    SetExecutedScriptReturnValue(X2_EXECUTE_SCRIPT_CONTINUE);
}
