// 5.3 changed public cd key to player name
// Levelling trainer = Use this in a used event for a placable object.

#include "hc_inc"
#include "dnd_inc_exp"

void main()
{
    object oPC=GetLastUsedBy();
    string sCDK=GetPCPlayerName(oPC);
    int nCurLvl=GetHitDice(oPC);
    int nCurXP=GetXP(oPC);
    int nGold=GetGold(oPC);
    int nReqXP=((nCurLvl+1) * (nCurLvl)) / 2 * 1000 -1;
    if(GetPersistentInt(oPC,"ALLOWLEVEL"))
    {
        SendMessageToPC(oPC,"You have already been trained.  Go ahead and level up");
        return;
    }
    if(nCurXP < nReqXP)
    {
        SendMessageToPC(oPC,"You do not yet have enough experience to level, go"+
            " and learn more.");
        return;
    }
    int nLevCost=GetLocalInt(oMod,"LEVELCOST");
    int nCost= nLevCost * nCurLvl;
    if(GetPersistentInt(oMod,"LEVELCOSTPEN"+GetName(oPC)+GetPCPlayerName(oPC)))
        nCost += nLevCost;
    if(nGold < nCost)
    {
        SendMessageToPC(oPC,"You need "+IntToString(nCost)+" gold to train.");
        return;
    }
    AssignCommand(OBJECT_SELF,TakeGoldFromCreature(nCost, oPC, TRUE));
    SetPersistentInt(oPC,"ALLOWLEVEL",1);
    SendMessageToPC(oPC,"You have completed your training and may now level up.");
    if(nCurXP > nReqXP) nCurXP=nReqXP;
    SetXP(oPC,nCurXP+1);
    if(GetLocalInt(GetModule(),"PWEXP"))
    {
        SetUpExp(oPC, 0);
    }
}
