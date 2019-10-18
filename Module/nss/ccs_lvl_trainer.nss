/******************************************************************************/
// ORS TRAINER (CCS by Darth John...Edited/Fixed by Olander for ORSv5)

////////////////////////////////////////////////////////////////////////////////
///
/// Class Control System (CCS)
/// Created on 11/25/03 by DarthJohn
/// Last Modified on 02/02/04 by DarthJohn
/// Originally based on HCR code (http://www.rpging.net/nwn)
///
/// Script: ccs_lvl_trainer
///
////////////////////////////////////////////////////////////////////////////////
///
/// DO NOT EDIT THIS SCRIPT!
/// This is the main script that handles level control.
///
////////////////////////////////////////////////////////////////////////////////

#include "ccs_inc"
#include "ccs_text"


void main()
{
    object oPC=GetPCSpeaker();
    object oTrainer=GetLocalObject(oPC,"PC_TRAINER");
    int bTrainerIsPC=TRUE;
    /// Determines if oTrainer is a PC Trainer or an NPC Trainer.
    if(!GetIsObjectValid(oTrainer))
    {
        oTrainer=OBJECT_SELF;
        bTrainerIsPC=FALSE;
    }
    int nCurLvl=GetHitDice(oPC);
    int nCurXP=GetXP(oPC);
    int nGold=GetGold(oPC);
    int nReqXP=((nCurLvl+1) * (nCurLvl)) / 2 * 1000 -1;
    int nLevDiff;
    int nCost=CCS_LEVEL_COST * nCurLvl;
    int nClassPos=1;
    int nLevPos=GetLevelByPosition(nClassPos,oPC);
    int nNPCClassType=GetLocalInt(oPC,"CLASS_TYPE");
    int nPCClassType=GetClassByPosition(nClassPos,oPC);
    int nChangeClass=GetLocalInt(oPC,"CHANGING_CLASS");

    //Record Cost So Player Can Retrain on 'Misclick' or 'Cheat'
    SetLocalInt(oPC, "CCS_GOLDCOST",nCost);

    /// Checks to see if CCS is enabled.
    if(CCS_CHARACTER_LEVEL_CONTROL)
    {

        /// Checks to see if PC has already trained.
        if(GetLocalInt(oPC,"ALLOWLEVEL"))
        {
            SendMessageToPC(oPC,TRAINED);
            RemoveVariables(oPC);
            if(bTrainerIsPC)
                ExecuteScript("ccs_c2_de_var",OBJECT_SELF);
            return;
        }


        /// Initial training check made, reset trainable classes.
        BlockAllClasses(oPC);

        /// Checks to see if PC has enough XP to train.
        if(nCurXP < nReqXP)
        {
            SendMessageToPC(oPC,MOREXP);
            RemoveVariables(oPC);
            if(bTrainerIsPC)
                ExecuteScript("ccs_c2_de_var",OBJECT_SELF);
            return;
        }

        /// Checks to see if PC leveler has enough character levels to take epic
        /// prestige levels.
        if(GetIsPrestigeClass(nNPCClassType)){
            if(nCurLvl <= 19 && GetLevelByClass(nNPCClassType,oPC) == 10){
               SendMessageToPC(oPC,NOEPIC);
               RemoveVariables(oPC);
               if(bTrainerIsPC)
                   ExecuteScript("ccs_c2_de_var",OBJECT_SELF);
               return;
            }
        }

        /// Checks to see if Epic Levels are enabled.
        if(CCS_EPIC_LEVEL_CONRTOL){
            if(nCurLvl >= 20){
                if(!GetCampaignInt(CCS_DATABASE,"ENABLE_EPIC_LEVELS",oPC)){
                    SendMessageToPC(oPC,NOEPIC);
                    RemoveVariables(oPC);
                    if(bTrainerIsPC)
                        ExecuteScript("ccs_c2_de_var",OBJECT_SELF);
                    return;
                }
            }
        }

        /// Checks to see if multiclassing is allowed.
        if(CCS_MULTICLASS_LEVEL_CONTROL){
            if(!CCS_MULTICLASS_LEVEL_AMOUNT){
                if(GetLevelByClass(nNPCClassType,oPC)){
                    AllowClass(oPC,nNPCClassType);
                }
                else{
                    SendMessageToPC(oPC,NOMULTICLASS);
                    RemoveVariables(oPC);
                    if(bTrainerIsPC)
                        ExecuteScript("ccs_c2_de_var",OBJECT_SELF);
                    return;
                }
            }
            else if(GetCanMulticlass(oPC) && nChangeClass)
                AllowClass(oPC,nNPCClassType);
            else if(GetIsMulticlassed(oPC) && GetIsTrainableClass(oPC,nNPCClassType))
                AllowClass(oPC,nNPCClassType);
            else{
                if(GetLevelByClass(nNPCClassType,oPC)){
                    AllowClass(oPC,nNPCClassType);
                }
                else{
                    SendMessageToPC(oPC,CANTTRAIN);
                    RemoveVariables(oPC);
                    if(bTrainerIsPC)
                        ExecuteScript("ccs_c2_de_var",OBJECT_SELF);
                    return;
                }
            }
        }
        else AllowAllClasses(oPC);

        /// Checks to see if NPC trainer has enough levels to train PC.
        /// If trainer is a PC, Trainer Restriction Policy is on by default.
        if(CCS_TRAINER_RESTRICTION || GetIsPC(oTrainer)){
            if(GetIsTrainableClass(oPC,nNPCClassType)){
                if(GetLevelByClass(nNPCClassType,oPC) >= GetLevelByClass(nNPCClassType,oTrainer)){
                    SendMessageToPC(oPC,TRAINEREXP);
                    if(bTrainerIsPC)
                        ExecuteScript("ccs_c2_de_var",OBJECT_SELF);
                    return;
                }
            }
        }

        /// Checks to see if PC should be charged for training.
        if(CCS_LEVEL_COST){
            if(CCS_LEVEL_COST_START){
                if(CCS_LEVEL_COST_PCTRAINER && GetIsPC(oTrainer)){
                    if(CCS_LEVEL_COST_PCTRAINER_FEE_START <= nCurLvl){
                        nCost=CCS_LEVEL_COST_PCTRAINER_FEE * nCurLvl;
                        if(nGold < nCost){
                            SendMessageToPC(oPC,NEEDGOLD1+IntToString(nCost)+NEEDGOLD2);
                            BlockAllClasses(oPC);
                            RemoveVariables(oPC);
                            if(bTrainerIsPC)
                                ExecuteScript("ccs_c2_de_var",OBJECT_SELF);
                            return;
                        }
                        AssignCommand(OBJECT_SELF,TakeGoldFromCreature(nCost,oPC,TRUE));
                    }
                }
                else if(CCS_LEVEL_COST_START <= nCurLvl){
                    if(nGold < nCost){
                        SendMessageToPC(oPC,NEEDGOLD1+IntToString(nCost)+NEEDGOLD2);
                        BlockAllClasses(oPC);
                        RemoveVariables(oPC);
                        if(bTrainerIsPC)
                            ExecuteScript("ccs_c2_de_var",OBJECT_SELF);
                        return;
                    }
                    AssignCommand(OBJECT_SELF,TakeGoldFromCreature(nCost,oPC,TRUE));
                }
            }
            else AssignCommand(OBJECT_SELF,TakeGoldFromCreature(nCost,oPC,TRUE));
        }

        /// PC has met all the requirements for training, level up.
        SetLocalInt(oPC,"ALLOWLEVEL",1);
        SendMessageToPC(oPC,LEVELUP);

        /// Checks to see if a PC trainer placeholder needs to be cleaned up.
        if(GetIsPC(oTrainer)){
            /// Checks to see if PC trainer should get XP for training PC trainee.
            if(CCS_PCTRAINER_XP_BONUS)
                GiveXPToCreature(oTrainer,CCS_PCTRAINER_XP_BONUS_VALUE*nCurLvl);
            DestroyObject(GetObjectByTag(GetLocalString(oPC,"CCS_CONV")));
        }

        // This checks to see if PC retains XP gained before advancing.
        if(CCS_XP_LEVEL_CAP){
            if(nCurXP > nReqXP) nCurXP=nReqXP;
            SetXP(oPC,nCurXP+1);
        }

    }
    RemoveVariables(oPC);
    if(bTrainerIsPC)
        ExecuteScript("ccs_c2_de_var",OBJECT_SELF);
}
