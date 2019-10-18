////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Realistic Herbal Bandage
//  ocr_herb_bandage
//  by Don Anderson
//
//  Script is from Scripting Forum By:
//  Greywolf2001ca/OwChalliw/Cereborn
//
//  This is a better version of the script I made for
//  same thing. Thanks.
//
//  Place this in the Modlue Activate Item Event
//
//  Here is how it works.
//  You can not use a Bandage when enemies are near.
//  You can apply these to yourself or others. Healing
//  is based upon your Skill Points in Healing. Higher
//  points means better heals.
//  Nobody heals like Clerics and Druids and that is one
//  of the reasons this was done.
//
////////////////////////////////////////////////////////////////////////////////

#include "ocr_include"

int DCHeal(object oTarget)
{
    //This Sets up how difficult the wounds are to heal -> i.e. Under 15% you have been cut to ribbons and tougher to
    //Heal with Bandages......This helps keep a Cleric around for Spell Healing.
    //NOTE: The more skill points in Healing result in better Healing Skill.....Duh =)
    int nCurHP = GetCurrentHitPoints(oTarget);
    int nMaxHP = GetMaxHitPoints(oTarget);
    int nDC = 5; //Initial DC as a %
    int nPerc = (nCurHP * 100) / nMaxHP;
    if (nPerc < 75) nDC = 10; //if percentage of health is less than 75%
    if (nPerc < 50) nDC = 15; //if percentage of health is less than 50%
    if (nPerc < 35) nDC = 20; //if percentage of health is less than 35%
    if (nPerc < 15) nDC = 30; //if percentage of health is less than 15%
    return nDC;
}

void main()
{
    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    object oTarget  = GetItemActivatedTarget();

    int nCharges    = GetItemCharges(oItem);
    int nTime       = (GetSkillRank(SKILL_HEAL, oPC) / 4) + 1;//Amount of Time it takes to Dress Wounds
    int nCurHP      = GetCurrentHitPoints(oTarget);
    int nMaxHP      = GetMaxHitPoints(oTarget);
    int nHeal       = GetSkillRank(SKILL_HEAL, oPC);
    int nCON        = GetAbilityModifier(ABILITY_CONSTITUTION,oTarget);//CON of Target is added to Heal Skill
    int nHMin       = 5; //Minimum added to Heal Skill
    int nSkill      = nHeal + nHMin + nCON;//Total Heal Skill

    int nRange      = 10;
    int nEIR        = FALSE; //IsEnemyInRange(oPC, IntToFloat(nRange));
    int nType       = GetObjectType(oTarget);

    //We make sure this is the Bandage
    if (GetTag(oItem) == "Bandage")
    {
      //Checks if an enemy is NOT in range and that the target is a creature
      if(nEIR == FALSE && nType == OBJECT_TYPE_CREATURE)
      {
        //Now we get the DC of the Heal and Skill of the Healer
        int nDC = DCHeal(oTarget);
        int nDieRoll = d20();
        if (nDieRoll + nSkill < nDC)
        {
          //We check to see if it is even possible for the Player to heal the wounds
          if (20 + GetSkillRank(SKILL_HEAL, oPC) < nDC)
          {
            SendMessageToPC(oPC, "[DC" + IntToString(nDC) + "]:Your skill in Healing is not sufficient enough to heal these wounds.");
          }
          //If the Player is capable then we tell them that they ruined the bandage.
          else SendMessageToPC(oPC, "[DC" + IntToString(nDC) + "]:You Ruined That Bandage.");
          return;
        }

        //Now we Heal the Target
        if(nSkill > (nMaxHP - nCurHP))
        {
          //We must make sure that we only heal up to the max hit points
          nSkill = nMaxHP - nCurHP;
        }
        effect eHeal = EffectHeal(nSkill);
        effect eVisual = EffectVisualEffect(VFX_IMP_TORNADO);
        DelayCommand(15.0 - (nTime * 1.0) , ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
        DelayCommand(15.0 - (nTime * 1.0) , ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget));
        SendMessageToPC(oPC, "[DC" + IntToString(nDC) + "]:Nicely dressed and finished. You will be healed " + IntToString(nSkill) + " points from this Bandage shortly. Herbs need a little time to set up.");
      }
      //If the Target is not a creature or enemies are present we add 1 charge back to the Bandage
      else
      {
        if(nEIR == TRUE) SendMessageToPC(oPC, "You may not use a Bandage while Enemies are Closer than "+IntToString(nRange)+" Meters");
        else if(nType != OBJECT_TYPE_CREATURE)
        {
          SendMessageToPC(oPC, "Target Must be a Creature.");
          object oNew = CreateItemOnObject(GetResRef(oItem),oPC);
          DestroyObject(oItem);
        }
      }
    }
}
