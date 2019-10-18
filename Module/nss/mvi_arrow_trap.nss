void main()
{
//USER DEFINED VARIABLES========================================================
//==============================================================================
    int iDmgType = DAMAGE_TYPE_PIERCING;
    int iDmgPow = DAMAGE_POWER_PLUS_FIVE;
//==============================================================================
//==============================================================================

    object oPC = GetEnteringObject();
    int iAC = GetAC(oPC);
      // the below grabs the last 2 digits of the trap tag, to use as the
      // trap's maximum damage
    int iDmg = StringToInt(GetStringRight(GetTag(OBJECT_SELF),2));
      // grab the trap's Detect DC to use as it's attack bonus
    int iAttack = GetTrapDetectDC(OBJECT_SELF);
      // use the below as the trap's random attack roll
    int iRoll = d20();
    string sOrigin = GetTag(OBJECT_SELF) + "_shooter";
    object oShooter = GetNearestObjectByTag(sOrigin);

      // if the trap shooter has been destroyed, do nothing
      // allows the PC to destroy the source to avoid the trap
    if (oShooter == OBJECT_INVALID)
    {   return;   }

    effect eDmg = EffectDamage((Random(iDmg)+1),iDmgType,iDmgPow);

      // send combat attack message to PC with details
    SendMessageToPC(oPC,"Arrow trap rolled "+
                        IntToString(iRoll)+" + "+
                        IntToString(iAttack)+
                        " = "+IntToString(iRoll+iAttack)+
                        " vs AC"+IntToString(iAC));

      // if the to-hit roll beats the PC's Armor Class, it's a hit
    if (iRoll+iAttack >= iAC)
    {
        AssignCommand(oShooter,ActionCastSpellAtObject(SPELL_TRAP_BOLT,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_HOMING));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg,oPC);
        //DelayCommand(1.0f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg,oPC));
    }
    else  // we missed;  fire the arrow but don't do any damage
    {
        AssignCommand(oShooter,ActionCastSpellAtObject(SPELL_TRAP_BOLT,oPC,METAMAGIC_ANY,TRUE,0,PROJECTILE_PATH_TYPE_HOMING));
    }
}
