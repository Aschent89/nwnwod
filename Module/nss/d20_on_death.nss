//::///////////////////////////////////////////////
//:: Name d20 Bleeding script
//:: FileName d20_on_death
//:://////////////////////////////////////////////
/*
on_death script that allows PCs to bleed at the rate of 1 hp per round before
actually dying. The PC must make a fortitude save against DC10+PC level to heal
1 hitpoint, otherwise the PC is damaged 1 hitpoint. Bleeding starts at -5 HP.
*/
//:://////////////////////////////////////////////
//:: Created By: Gulfwulf
//:: Created On: 11/20/2007
//:: Modified by Vanya Mia May/09
//:://////////////////////////////////////////////

#include "inc_d20"

void bleed() //The bleeding function.
{
    object oPC = OBJECT_SELF;
    effect eBleedEff;
    if ((GetCurrentHitPoints(oPC) <= 0) && (GetCurrentHitPoints(oPC) >=-9)) //Is the player bleeding?
    {
        int nFort = FortitudeSave(oPC,10+GetHitDice(oPC)); //Run the fortitude DC check. Default 10 + PC level
        if (nFort != 1) //Failed save.
        {
            eBleedEff = EffectDamage(1);//Damage (bleed) the PC.
            switch (d6()) //Play a help voicechat.
            {
                case 1: PlayVoiceChat(VOICE_CHAT_PAIN1); break;
                case 2: PlayVoiceChat(VOICE_CHAT_PAIN2); break;
                case 3: PlayVoiceChat(VOICE_CHAT_PAIN3); break;
                case 4: PlayVoiceChat(VOICE_CHAT_HEALME); break;
                case 5: PlayVoiceChat(VOICE_CHAT_NEARDEATH); break;
                case 6: PlayVoiceChat(VOICE_CHAT_HELP);
            }
        }
        else
        {
            eBleedEff = EffectHeal(1); //Save made, heal the PC one hitpoint.
        }
        SetPlotFlag(oPC, FALSE); //Turn off the plot flag so we can either heal or damage the PC.
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBleedEff, oPC);//Apply damage or healing.
        int iHP = GetCurrentHitPoints(oPC); //Get the current hitpoints to determine if the PC is dead, dying, or has recovered.
        FloatingTextStringOnCreature(GetPCPlayerName(oPC)+" is bleeding at "+IntToString(iHP), oPC); //Give the current hitpoints.
        SetPlotFlag(oPC, TRUE); //Turn the plot flag back on to protect the PC from taking additional damage from enemies or spells.
    }
    /* -10 hit points is the default death threshold, at or beyond it the character dies */
    if (GetCurrentHitPoints() <= -10)
    {
        SetPlotFlag(oPC, FALSE);
        PlayVoiceChat(VOICE_CHAT_DEATH); /* scream one last time */
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), OBJECT_SELF); /* make death dramatic */
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF); /* now kill them */
        // * make friendly to Each of the 3 common factions
        if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oPC) <= 10)
        {
            SetLocalInt(oPC, "NW_G_Playerhasbeenbad", 10); // * Player bad
            SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oPC);
        }
        if (GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oPC) <= 10)
        {
            SetLocalInt(oPC, "NW_G_Playerhasbeenbad", 10); // * Player bad
            SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oPC);
        }
        if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oPC) <= 10)
        {
            SetLocalInt(oPC, "NW_G_Playerhasbeenbad", 10); // * Player bad
            SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oPC);
        }
        SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 0, oPC); //Reset the hostile faction.
        SetLocalInt(oPC, "nd203RoundsDead", 0);
        SetLocalInt(oPC, "nD203MinutesDead", 0);
        DelayCommand(48.0, SetLocalInt(oPC, "nd203RoundsDead", 1));
        DelayCommand(210.0, SetLocalInt(oPC, "nD203MinutesDead", 1));
        DeleteLocalInt(oPC, "dying"); //The PC is no longer bleeding.
        SetLocalInt(oPC, "dead", 1); //Tell the on_death script that this PC is dead to prevent healing from running again.
        return;
    }
    if (GetCurrentHitPoints() > 0) //Has the PC recovered?
    {
        SetPlotFlag(oPC, FALSE); //Make them vunerable again.
        DeleteLocalInt(oPC, "dying"); //Tell the computer that the PC is no longer dead or dying.
        DeleteLocalInt(oPC, "dead");
        //reset class & feat bonuses
        ExecuteScript("d20_setbonuses",oPC);
        DelayCommand(6.0, SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 0, oPC)); //Reset the hostile faction.
        return;
    }
    DelayCommand(6.0, AssignCommand(oPC, bleed())); /* do this again next round */
}


void main()
{
    object oPC = GetLastPlayerDied();//Get the last person who died and start the bleeding process.
    if(GetLocalInt(oPC, "dead") ==1) //Has the PC already died after bleeding?
    {
        DeleteLocalInt(oPC, "dead"); //If so, reset the already dead status and return.
        return;
    }
    if(!GetIsPC(oPC)) return; //Don't run this script on NPCs.
    int iHP = GetCurrentHitPoints(oPC);
    if (GetHasFeat(FEAT_REMAINCONSCIOUS, oPC)) //Does the PC have the d20 feat Remain Concious?
    {
        if (GetLocalInt(oPC, "nMdrnRemainConscious")==0) //If so, check to see if the feat has already been used.
        {
            SetPlotFlag(oPC, TRUE); //Turn the PC invunerable temporarily.
            AssignCommand(oPC, ClearAllActions());
            SetPlotFlag(oPC, FALSE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC); //Dead PCs can't bleed, so resurrect the PC.
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(iHP+1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE), oPC); //Set the hitpoints to -1.
            SetLocalInt(oPC, "nMdrnRemainConscious", 1); //Tell the computer the feat has been used.
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(11), oPC); //Heal the PC to 10 hitpoints.
            return;
        }
    }
    SetLocalInt(oPC, "dying", 1); //Tell the computer that the bleeding script is already active.
    AssignCommand(oPC, ClearAllActions());
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC); //Dead PCs can't bleed, so perform a resurrection. Code taken from HABD.
    iHP = GetCurrentHitPoints(oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(iHP+5, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE), oPC); //Take the PC down to -5 hitpoints.
    effect eBad = GetFirstEffect(oPC);
    //Search for negative effects
    while(GetIsEffectValid(eBad)) //Code taken from Bioware's Original Campaign temple healing script.
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
            GetEffectType(eBad) == EFFECT_TYPE_CURSE ||
            GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
            GetEffectType(eBad) == EFFECT_TYPE_POISON ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
        {
            //Remove effect if it is negative.
            RemoveEffect(oPC, eBad);
        }
        eBad = GetNextEffect(oPC);
    }
    AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectInvisibility(INVISIBILITY_TYPE_NORMAL), oPC, 6.0));
    SetPlotFlag(oPC, TRUE); //Turn the PC invunerable temporarily.
    SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 50, oPC); //Reset the hostile faction.
    int n=1;
    object oEnemy = GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE, oPC, n,CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC); //Stop the current enemies from attacking the PC. Code take from HABD.
    while (oEnemy != OBJECT_INVALID)
    {
        if (GetAttackTarget(oEnemy) == oPC)
        {
            AssignCommand(oEnemy, ClearAllActions(TRUE));
        }
        n=n+1;
        oEnemy = GetNearestCreature(CREATURE_TYPE_IS_ALIVE,TRUE, oPC, n, CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC);
    }
    AssignCommand(oPC, bleed()); //Start the bleeding process.
}
