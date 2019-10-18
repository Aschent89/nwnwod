//::///////////////////////////////////////////////
//:: Custom Cursesong Library
//:: inc_cursesong
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Kilana Evra
//:: Created On:
//:://////////////////////////////////////////////
#include "x2_i0_spells"


//:://////////////////////////////////////////////
//:: Internal Functions
//:://////////////////////////////////////////////

int RandomAnimal(int nCheck)
{ int nResult = POLYMORPH_TYPE_BADGER;
  switch(nCheck)
  { case 1: nResult = POLYMORPH_TYPE_BOAR; break;
    case 2: nResult = POLYMORPH_TYPE_CHICKEN; break;
    case 3: nResult = POLYMORPH_TYPE_COW; break;
    case 4: nResult = POLYMORPH_TYPE_DIRE_BADGER; break;
    case 5: nResult = POLYMORPH_TYPE_DIRE_BOAR; break;
    case 6: nResult = POLYMORPH_TYPE_BADGER; break;
    case 7: nResult = POLYMORPH_TYPE_IMP; break;
    case 8: nResult = POLYMORPH_TYPE_PANTHER; break;
    case 9: nResult = POLYMORPH_TYPE_PENGUIN; break;
    case 10: nResult = POLYMORPH_TYPE_WOLF; break;
    case 11: nResult = POLYMORPH_TYPE_QUASIT; break;
    case 12: nResult = POLYMORPH_TYPE_GIANT_SPIDER; break;
    case 13: nResult = POLYMORPH_TYPE_PENGUIN; break;
    case 14: nResult = POLYMORPH_TYPE_CHICKEN; break;
    case 15: nResult = POLYMORPH_TYPE_COW; break;
  }
  return nResult;
}

void SlanderString(object oTarget)
{ string sResult;

  int nRandom = Random(7);
  switch(nRandom)
  { case 0: sResult="Damn, if only all your mother's were as good as your sisters!"; break;
    case 1: sResult="When the gods gave you all teeth, he spoiled some bloody good arses!"; break;
    case 2: sResult="Idiots! Think I'm getting smart with you? How would you know?!"; break;
    case 3: sResult="If assholes were ships, this place would be a bloody port."; break;
    case 4: sResult="I'd ask how old ya'll are, but none of ya can count that high!"; break;
    case 5: sResult="*mumbles* Never underestimate the power of stupid people in large groups."; break;
    case 6: sResult="If any of ya get captured, go ahead and tell all ya know... since it'd only take 10 seconds."; break;
  }
  AssignCommand(oTarget, SpeakString(sResult));
return;
}

void RespondString(object oTarget)
{ int nRandom = d4(1);
  string sResult;
  switch(nRandom)
  { case 1: sResult = "What was that?!"; break;
    case 2: sResult = "Why you!"; break;
    case 3: sResult = "Say that again!"; break;
    case 4: sResult = "THAT IS IT!"; break;
  }
  AssignCommand(oTarget, SpeakString(sResult));
return;
}

//////////////////////////////////////////////////

//Default Bioware Cursesong
void SongCurse(object oPC, int nSongStrength, int nDuration)
{ int nAttack, nDamage, nWill, nFort, nReflex, nHP, nAC, nSkill;

  if(nSongStrength==23)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 48;
    nAC = 7;
    nSkill = 19;
  }
  else if(nSongStrength==22)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 46;
    nAC = 6;
    nSkill = 18;
  }
  else if(nSongStrength==21)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 44;
    nAC = 6;
    nSkill = 17;
  }
  else if(nSongStrength==20)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 42;
    nAC = 6;
    nSkill = 16;
  }
  else if(nSongStrength==19)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 40;
    nAC = 6;
    nSkill = 15;
  }
  else if(nSongStrength==18)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 38;
    nAC = 6;
    nSkill = 14;
  }
  else if(nSongStrength==17)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 36;
    nAC = 5;
    nSkill = 13;
  }
  else if(nSongStrength==16)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 34;
    nAC = 5;
    nSkill = 12;
  }
  else if(nSongStrength==15)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 32;
    nAC = 5;
    nSkill = 11;
  }
  else if(nSongStrength==14)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 30;
    nAC = 5;
    nSkill = 9;
  }
  else if(nSongStrength==13)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 28;
    nAC = 5;
    nSkill = 8;
  }
  else if(nSongStrength==12)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 26;
    nAC = 5;
    nSkill = 7;
  }
  else if(nSongStrength==11)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 24;
    nAC = 5;
    nSkill = 6;
  }
  else if(nSongStrength==10)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 22;
    nAC = 5;
    nSkill = 5;
  }
  else if(nSongStrength==9)
  { nAttack = 2;
    nDamage = 3;
    nWill = 3;
    nFort = 2;
    nReflex = 2;
    nHP = 20;
    nAC = 5;
    nSkill = 4;
  }
  else if(nSongStrength==8)
  { nAttack = 2;
    nDamage = 3;
    nWill = 2;
    nFort = 2;
    nReflex = 2;
    nHP = 16;
    nAC = 4;
    nSkill = 3;
  }
  else if(nSongStrength==7)
  { nAttack = 2;
    nDamage = 3;
    nWill = 1;
    nFort = 1;
    nReflex = 1;
    nHP = 16;
    nAC = 3;
    nSkill = 2;
  }
  else if(nSongStrength==6)
  { nAttack = 2;
    nDamage = 2;
    nWill = 1;
    nFort = 1;
    nReflex = 1;
    nHP = 8;
    nAC = 2;
    nSkill = 2;
  }
  else if(nSongStrength==5)
  { nAttack = 2;
    nDamage = 2;
    nWill = 1;
    nFort = 1;
    nReflex = 1;
    nHP = 8;
    nSkill = 1;
  }
  else if(nSongStrength==4)
  { nAttack = 1;
    nDamage = 2;
    nWill = 1;
    nFort = 1;
    nReflex = 1;
    nSkill = 1;
  }
  else if(nSongStrength==3)
  { nAttack = 1;
    nDamage = 2;
    nWill = 1;
    nFort = 1;
  }
  else if(nSongStrength==2)
  { nAttack = 1;
    nDamage = 1;
    nWill = 1;
  }
  else if(nSongStrength==1)
  { nAttack = 1;
    nDamage = 1;
  }

  effect eAttack = EffectAttackDecrease(nAttack);
  effect eDamage = EffectDamageDecrease(nDamage, DAMAGE_TYPE_SLASHING);
  effect eWill, eFort, eReflex, eHP, eAC, eSkill;
  effect eLink = EffectLinkEffects(eAttack, eDamage);
  if(nWill > 0)
  { eWill = EffectSavingThrowDecrease(SAVING_THROW_WILL, nWill);
    eLink = EffectLinkEffects(eLink, eWill);
  }
  if(nFort > 0)
  { eFort = EffectSavingThrowDecrease(SAVING_THROW_FORT, nFort);
    eLink = EffectLinkEffects(eLink, eFort);
  }
  if(nReflex > 0)
  { eReflex = EffectSavingThrowDecrease(SAVING_THROW_REFLEX, nReflex);
    eLink = EffectLinkEffects(eLink, eReflex);
  }
  if(nHP > 0) eHP = EffectDamage(nHP, DAMAGE_TYPE_SONIC, DAMAGE_POWER_NORMAL);
  if(nAC > 0)
  { eAC = EffectACDecrease(nAC, AC_DODGE_BONUS);
    eLink = EffectLinkEffects(eLink, eAC);
  }
  if(nSkill > 0)
  { eSkill = EffectSkillDecrease(SKILL_ALL_SKILLS, nSkill);
    eLink = EffectLinkEffects(eLink, eSkill);
  }
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
  eLink = EffectLinkEffects(eLink, eDur);
  eHP = ExtraordinaryEffect(eHP);
  eLink = ExtraordinaryEffect(eLink);

  effect eVis = EffectVisualEffect(VFX_IMP_DOOM);
  effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
  effect eVis2 = EffectVisualEffect(507);

  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));

  if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
  { eVis2 = ExtraordinaryEffect(eVis2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oPC, RoundsToSeconds(nDuration));
  }
  float fDelay;
  while(GetIsObjectValid(oTarget))
  { if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oPC))
    { // * GZ Oct 2003: If we are deaf, we do not have negative effects from curse song
      if (!GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
        { if (nHP > 0)
          { ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
            DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHP, oTarget));
          }

          if (!GetIsDead(oTarget))
          { ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
            DelayCommand(GetRandomDelay(0.1,0.5),ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
          }
        }
      }
      else
      { ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), oTarget);
      }
    }

    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
  DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
}

/*
   All creatures - Hide/Move Silent Penalty = SongLevel + (1/song level>13)
   Invisible Creatures - Concentration vs. Perform or Revealed
*/
void SongReveal(object oPC, int nSongStrength, int nDuration, int nPerform)
{ //Penalties Here
  int nSkill = nSongStrength;
  if(nSongStrength>=13) nSkill = nSkill + nSongStrength-12; //+2 Per Level after 20
  if(nSongStrength>=18) nSkill = nSkill + nSongStrength-17; //+3 Per Level after 25
  if(nSongStrength>=23) nSkill = nSkill + 1;                //+4 Per Level at 30

  effect eSkill = EffectSkillDecrease(SKILL_MOVE_SILENTLY, nSkill);
  effect eSkill2 = EffectSkillDecrease(SKILL_HIDE, nSkill);
  effect eLink = EffectLinkEffects(eSkill, eSkill2);
  eLink = ExtraordinaryEffect(eLink);

  //Visuals
  effect eVis = EffectVisualEffect(VFX_IMP_HEAD_ODD);
  effect eImpact = EffectVisualEffect(92);
  effect eVis2 = EffectVisualEffect(507); //BardSong VFX2

  //Loop
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));

  if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
  { eVis2 = ExtraordinaryEffect(eVis2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oPC, RoundsToSeconds(nDuration));
  }
  float fDelay;
  while(GetIsObjectValid(oTarget))
  { if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oPC))
    { // * GZ Oct 2003: If we are deaf, we do not have negative effects from curse song
      if (!GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
        { //Damage Here
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
        }
      }
      else //Target is Deaf, VFX
      { ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), oTarget);
      }
      //Non Deaf Dependant Damage Here
      if(GetHasSpellEffect(SPELL_IMPROVED_INVISIBILITY, oTarget)
      || GetHasSpellEffect(SPELL_INVISIBILITY, oTarget)
      || GetHasSpellEffect(SPELLABILITY_AS_INVISIBILITY, oTarget)
      || GetHasSpellEffect(SPELLABILITY_AS_IMPROVED_INVISIBLITY))
      { if(!GetIsSkillSuccessful(oTarget, SKILL_CONCENTRATION, nPerform))
        { RemoveAnySpellEffects(SPELL_IMPROVED_INVISIBILITY, oTarget);
          RemoveAnySpellEffects(SPELL_INVISIBILITY, oTarget);
          RemoveAnySpellEffects(SPELLABILITY_AS_INVISIBILITY, oTarget);
          RemoveAnySpellEffects(SPELLABILITY_AS_IMPROVED_INVISIBLITY, oTarget);
        }
      }
      DelayCommand(GetRandomDelay(0.1,0.5),ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
    }

    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
  DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);

}

/*
   Enemy must make Concentration vs. Perform or Fail spells for 1 round
*/
void SongJarring(object oPC, int nSongStrength, int nDuration, int nPerform)
{ //Penalties Here
  if(nDuration>20) nDuration = 2;
  else nDuration = 1;

  effect ePenalty = EffectSpellFailure(100);
  effect eLink = ePenalty;
  eLink = ExtraordinaryEffect(eLink);

  //Visuals
  effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
  effect eImpact = EffectVisualEffect(293);
  effect eVis2 = EffectVisualEffect(507); //BardSong VFX2

  //Loop
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));

  if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
  { eVis2 = ExtraordinaryEffect(eVis2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oPC, RoundsToSeconds(nDuration));
  }
  float fDelay;
  while(GetIsObjectValid(oTarget))
  { if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oPC))
    { // * GZ Oct 2003: If we are deaf, we do not have negative effects from curse song
      if (!GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
        { //Damage Here
          if(!GetIsSkillSuccessful(oTarget, SKILL_CONCENTRATION, nPerform))
          { ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
            DelayCommand(GetRandomDelay(0.1,0.5),ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
          }
        }
      }
      else //Target is Deaf, VFX
      { ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), oTarget);
      }
      //Non Deaf Dependant Damage Here
    }

    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
  DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);

}

/*
   Spell Failure
*/
void SongInsidious(object oPC, int nSongStrength, int nDuration, int nPerform)
{ //Penalties Here
  int nPenalty = 2*nSongStrength +1; //+2% Per Level
  if(nSongStrength>=13) nPenalty = nPenalty + nSongStrength-12; //+3% Per Level after 20
  if(nSongStrength>=18) nPenalty = nPenalty + nSongStrength-17; //+4% Per Level after 25
  if(nSongStrength>=23) nPenalty = nPenalty + 1;                //+5% Per Level at 30 (65% Total Bonus)

  effect ePenalty = EffectSpellFailure(nPenalty);
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
  effect eLink = EffectLinkEffects(ePenalty, eDur);
  eLink = ExtraordinaryEffect(eLink);

  //Visuals
  effect eVis = EffectVisualEffect(VFX_IMP_SILENCE);
  effect eImpact = EffectVisualEffect(49);
  effect eVis2 = EffectVisualEffect(507); //BardSong VFX2

  //Loop
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));

  if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
  { eVis2 = ExtraordinaryEffect(eVis2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oPC, RoundsToSeconds(nDuration));
  }
  float fDelay;
  while(GetIsObjectValid(oTarget))
  { if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oPC))
    { // * GZ Oct 2003: If we are deaf, we do not have negative effects from curse song
      if (!GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
        { //Damage Here
          if(!GetIsSkillSuccessful(oTarget, SKILL_CONCENTRATION, nPerform))
          { ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
            DelayCommand(GetRandomDelay(0.1,0.5),ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
          }
        }
      }
      else //Target is Deaf, VFX
      { ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), oTarget);
      }
      //Non Deaf Dependant Damage Here
    }

    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
  DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);

}

void SongDiscord(object oPC, int nSongStrength, int nDuration)
{ //Penalties Here
  int nPenalty = 0;
  if(nSongStrength==23) nPenalty = 5;
  else if(nSongStrength>=18) nPenalty = 4;
  else if(nSongStrength>=13) nPenalty = 3;
  else if(nSongStrength>=6) nPenalty = 2;
  else if(nSongStrength>=4) nPenalty = 1;
  else
  { FloatingTextStringOnCreature("You try to sing the song, but the words tangle in your mouth.", oPC);
    DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
    return;
  }
  itemproperty iPenalty = ItemPropertyEnhancementPenalty(nPenalty);
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
  effect eLink = eDur;
  eLink = ExtraordinaryEffect(eLink);

  //Visuals
  effect eVis = EffectVisualEffect(VFX_IMP_SILENCE);
  effect eImpact = EffectVisualEffect(82);
  effect eVis2 = EffectVisualEffect(507); //BardSong VFX2

  //Define Variables
  object oWeapon, oOffhand;

  //Loop
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));

  if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
  { eVis2 = ExtraordinaryEffect(eVis2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oPC, RoundsToSeconds(nDuration));
  }
  float fDelay;
  while(GetIsObjectValid(oTarget) && nSongStrength>0)
  { if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oPC))
    { // * GZ Oct 2003: If we are deaf, we do not have negative effects from curse song
      if (!GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
        { //Damage Here
        }
      }
      else //Target is Deaf, VFX
      { ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), oTarget);
      }
      //Non Deaf Dependant Damage Here
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
      oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
      oOffhand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
      if(GetIsObjectValid(oWeapon))
      { IPSafeAddItemProperty(oWeapon, iPenalty, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
        nSongStrength--;
        if(GetIsPC(oTarget)) SendMessageToPC(oTarget, GetName(oWeapon)+" resonates with the music.");
      }
      if(GetIsObjectValid(oOffhand))
      { IPSafeAddItemProperty(oOffhand, iPenalty, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
        nSongStrength--;
      }
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
      DelayCommand(GetRandomDelay(0.1,0.5),ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
    }

    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
  DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);

}

void SongRhapsody(object oPC, int nSongStrength)
{ int nCount = GetLocalInt(oPC, "RHAPSODYCOUNT");
  if(nCount==0)
  { SetLocalInt(oPC, "RHAPSODYCOUNT", 1);
    DelayCommand(RoundsToSeconds(nSongStrength), DeleteLocalInt(oPC, "RHAPSODYCOUNT"));
    nCount++;
  }
  else
  { nCount++;
    SetLocalInt(oPC, "RHAPSODYCOUNT", nCount);
  }

  int nDC = 8;
  if(nCount<=5) nDC = 8 + nCount*4;        //+4  has DC 24
  else if(nCount<=10) nDC = 12 + nCount*5; //+9  has DC 57
  else if(nCount<=15) nDC = 16 + nCount*6; //+14 has DC 100
  else if(nCount<=20) nDC = 20 + nCount*7; //+19 has DC 153
  else nDC = 24 + nCount*8;

  string sPronoun = "her";
  if(GetGender(oPC)==GENDER_MALE) sPronoun="his";

  if(!GetIsSkillSuccessful(oPC, SKILL_PERFORM, nDC)) //Failed
  { FloatingTextStringOnCreature(GetName(oPC)+"'s voice cracks!", oPC, FALSE);
    DeleteLocalInt(oPC, "RHAPSODYCOUNT");
    effect eSilence = EffectSilence();
    effect eVis2 = EffectVisualEffect(VFX_DUR_CESSATE_NEUTRAL);
    eSilence = EffectLinkEffects(eSilence, eVis2);
    eSilence = ExtraordinaryEffect(eSilence);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSilence, oPC, RoundsToSeconds(10));
    return;
  }
  else
  { FloatingTextStringOnCreature(GetName(oPC)+" raises "+sPronoun+" song's volume to "+IntToString(nCount)+"!", oPC, FALSE);
  }

  //Bonuses Here
  effect eDamage;

  //Visuals
  effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
  effect eImpact = EffectVisualEffect(302);
  effect eVis2 = EffectVisualEffect(507); //BardSong VFX2

  //Loop
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));

  if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
  { eVis2 = ExtraordinaryEffect(eVis2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oPC, RoundsToSeconds(1));
  }
  float fDelay;
  while(GetIsObjectValid(oTarget))
  { if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oPC))
    { // * GZ Oct 2003: If we are deaf, we do not have negative effects from curse song
      if (!GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
        { //Damage Here
          eDamage = EffectDamage(d6(nCount), DAMAGE_TYPE_SONIC);
          eDamage = ExtraordinaryEffect(eDamage);

          ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          DelayCommand(GetRandomDelay(0.1,0.5),ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
      }
      else //Target is Deaf, VFX
      { ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), oTarget);
      }
      //Non Deaf Dependant Damage Here
    }

    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
  DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
}

void SongCalumny(object oPC, int nSongStrength, int nDuration)
{ //Visuals
  effect eVis = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
  effect eImpact = EffectVisualEffect(VFX_IMP_CHARM);
  effect eVis2 = EffectVisualEffect(507); //BardSong VFX2

  //Setup Variables
  object oSlander;
  int nCount = 10, nPCCha, nFail, nDC1;
  nPCCha = GetAbilityModifier(ABILITY_CHARISMA, oPC) +nSongStrength +d20(1);

  //Loop
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
  { eVis2 = ExtraordinaryEffect(eVis2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oPC, RoundsToSeconds(1));
  }
  float fDelay;
  while(GetIsObjectValid(oTarget)&& nFail!=1)
  { if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oPC))
    { // * GZ Oct 2003: If we are deaf, we do not have negative effects from curse song
      if (!GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
        { if(!GetIsObjectValid(oSlander)) //First Target
          { nDC1 = GetAbilityModifier(ABILITY_CHARISMA, oTarget) + GetHitDice(oTarget) + d20(1);
            string sGender = "his";
            if(GetGender(OBJECT_SELF)==GENDER_FEMALE) sGender = "her";
            FloatingTextStringOnCreature("Charisma: "+GetName(oPC)+" attempts to throw "+sGender+" voice!", oPC);

            if(nPCCha>=nDC1) //Success beating CHA
            { oSlander = oTarget;
              DelayCommand(0.5, SlanderString(oSlander));
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
            }
            else             //Failure to beat CHA
            { nFail=1;
              DelayCommand(0.5, FloatingTextStringOnCreature("Charisma: Failure!", oPC));
            }
          }
          else //Other Targets + Slander valid
          { nCount = nCount + 4 + GetHitDice(oTarget)/2; //DC increases by HD/2 of each creature
            SetLocalInt(oTarget, "SLANDERTHEM", 1);
          }
        }
      }
      else //Target is Deaf, VFX
      { ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), oTarget);
      }
      //Non Deaf Dependant Damage Here
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }

  oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));

if(nFail!=1)
{
 if(nCount>10)
 {
  if(GetIsSkillSuccessful(oPC, SKILL_PERFORM, nCount))
  { while(GetIsObjectValid(oTarget))
    { if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oPC))
      { if(GetLocalInt(oTarget, "SLANDERTHEM")==1)
        { SetIsTemporaryEnemy(oSlander, oTarget, TRUE, RoundsToSeconds(nDuration+10));
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
          AssignCommand(oTarget, ClearAllActions());
          AssignCommand(oTarget, ActionAttack(oSlander));
          RespondString(oTarget);
        }
      }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
    }
  }
  else DelayCommand(1.5, AssignCommand(oSlander, SpeakString("WHO DID THAT?!")));
 }
}
  DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
}

void SongEleWeak(object oPC, int nSongStrength, int nDuration, int nType = DAMAGE_TYPE_FIRE, int nVFX = VFX_IMP_SONIC)
{ //Penalties Here
  int nPenalty = 2*nSongStrength +6; //+2% Per Level
  if(nSongStrength>=13) nPenalty = nPenalty + nSongStrength-12; //+3% Per Level after 20
  if(nSongStrength>=18) nPenalty = nPenalty + nSongStrength-17; //+4% Per Level after 25
  if(nSongStrength>=23) nPenalty = nPenalty + 1;                //+5% Per Level at 30 (70% Total Bonus)

  effect ePenalty = EffectDamageImmunityDecrease(nType, nPenalty);
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
  effect eLink = EffectLinkEffects(ePenalty, eDur);
  eLink = ExtraordinaryEffect(eLink);

  //Visuals
  effect eVis = EffectVisualEffect(nVFX);
  effect eVis2 = EffectVisualEffect(507); //BardSong VFX2

  //Loop
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));

  if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
  { eVis2 = ExtraordinaryEffect(eVis2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oPC, RoundsToSeconds(nDuration));
  }
  float fDelay;
  while(GetIsObjectValid(oTarget))
  { if(spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, oPC))
    { // * GZ Oct 2003: If we are deaf, we do not have negative effects from curse song
      if (!GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
        { //Damage Here
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
          DelayCommand(GetRandomDelay(0.1,0.5),ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
      }
      else //Target is Deaf, VFX
      { ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), oTarget);
      }
      //Non Deaf Dependant Damage Here
    }

    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
  DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
}

void SongSResist(object oPC, int nSongStrength, int nDuration, int nVFX = VFX_IMP_SILENCE)
{ //Penalties Here
  effect ePenalty = EffectSpellResistanceDecrease(nSongStrength);
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
  effect eLink = EffectLinkEffects(ePenalty, eDur);
  eLink = ExtraordinaryEffect(eLink);

  //Visuals
  effect eVis = EffectVisualEffect(nVFX);
  effect eVis2 = EffectVisualEffect(507); //BardSong VFX2

  //Loop
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));

  if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
  { eVis2 = ExtraordinaryEffect(eVis2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oPC, RoundsToSeconds(nDuration));
  }
  float fDelay;
  while(GetIsObjectValid(oTarget))
  { if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oPC))
    { // * GZ Oct 2003: If we are deaf, we do not have negative effects from curse song
      if (!GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
        { //Damage Here
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
          DelayCommand(GetRandomDelay(0.1,0.5),ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
      }
      else //Target is Deaf, VFX
      { ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), oTarget);
      }
      //Non Deaf Dependant Damage Here
    }

    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
  DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
}

void SongTResist(object oPC, int nSongStrength, int nDuration, int nVFX = VFX_IMP_MAGBLUE)
{ //Penalties Here
  nSongStrength++;
  effect ePenalty = EffectTurnResistanceDecrease(nSongStrength/2);
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
  effect eLink = EffectLinkEffects(ePenalty, eDur);
  eLink = ExtraordinaryEffect(eLink);

  //Visuals
  effect eVis = EffectVisualEffect(nVFX);
  effect eVis2 = EffectVisualEffect(507); //BardSong VFX2

  //Loop
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));

  if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
  { eVis2 = ExtraordinaryEffect(eVis2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oPC, RoundsToSeconds(nDuration));
  }
  float fDelay;
  while(GetIsObjectValid(oTarget))
  { if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oPC))
    { // * GZ Oct 2003: If we are deaf, we do not have negative effects from curse song
      if (!GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
        { //Damage Here
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
          DelayCommand(GetRandomDelay(0.1,0.5),ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        }
      }
      else //Target is Deaf, VFX
      { ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), oTarget);
      }
      //Non Deaf Dependant Damage Here
    }

    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
  DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
}

void SongCrazyFarm(object oPC, int nSongStrength, int nDuration)
{ //Penalties Here
  int nDC = 4 + nSongStrength;

  effect ePoly = EffectPolymorph(POLYMORPH_TYPE_CHICKEN, TRUE);
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
  effect eLink; // = EffectLinkEffects(ePoly, eDur);
  //eLink = ExtraordinaryEffect(eLink);

  //Visuals
  effect eVis = EffectVisualEffect(VFX_IMP_BLIND_DEAF_M);
  effect eImpact = EffectVisualEffect(49);
  effect eVis2 = EffectVisualEffect(507); //BardSong VFX2

  //Loop
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));

  if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
  { eVis2 = ExtraordinaryEffect(eVis2);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oPC, RoundsToSeconds(nDuration));
  }
  float fDelay;
  while(GetIsObjectValid(oTarget))
  { if(spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, oPC))
    { // * GZ Oct 2003: If we are deaf, we do not have negative effects from curse song
      if (!GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(!GetHasFeatEffect(871, oTarget)&& !GetHasSpellEffect(GetSpellId(),oTarget))
        { //Damage Here
          if(!WillSave(oTarget, nDC, SAVING_THROW_TYPE_SPELL))
          { ePoly = EffectPolymorph(RandomAnimal(Random(16)), TRUE);
            eLink = EffectLinkEffects(ePoly, eDur);
            eLink = ExtraordinaryEffect(eLink);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
            DelayCommand(GetRandomDelay(0.1,0.5),ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
          }
        }
      }
      else //Target is Deaf, VFX
      { ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), oTarget);
      }
      //Non Deaf Dependant Damage Here
    }

    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
  DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
}
