//::///////////////////////////////////////////////
//:: Custom Bardsong Library
//:: inc_bardsong
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Kilana Evra
//:: Created On:
//:://////////////////////////////////////////////
#include "x0_i0_spells"


//:://////////////////////////////////////////////
//:: Internal Functions
//:://////////////////////////////////////////////
int GetPierceSlash(object oItem)
{ int nCheck = GetBaseItemType(oItem);
  int nResult = 0;
  switch(nCheck)
  { case BASE_ITEM_BASTARDSWORD: nResult=1; break;
    case BASE_ITEM_BATTLEAXE: nResult=1; break;
    case BASE_ITEM_DAGGER: nResult=1; break;
    case BASE_ITEM_DOUBLEAXE: nResult=1; break;
    case BASE_ITEM_DWARVENWARAXE: nResult=1; break;
    case BASE_ITEM_GREATAXE: nResult=1; break;
    case BASE_ITEM_GREATSWORD: nResult=1; break;
    case BASE_ITEM_HALBERD: nResult=1; break;
    case BASE_ITEM_HANDAXE: nResult=1; break;
    case BASE_ITEM_KAMA: nResult=1; break;
    case BASE_ITEM_KATANA: nResult=1; break;
    case BASE_ITEM_KUKRI: nResult=1; break;
    case BASE_ITEM_LONGSWORD: nResult=1; break;
    case BASE_ITEM_RAPIER: nResult=1; break;
    case BASE_ITEM_SCIMITAR: nResult=1; break;
    case BASE_ITEM_SCYTHE: nResult=1; break;
    case BASE_ITEM_SHORTSPEAR: nResult=1; break;
    case BASE_ITEM_SHORTSWORD: nResult=1; break;
    case BASE_ITEM_SICKLE: nResult=1; break;
    case BASE_ITEM_TRIDENT: nResult=1; break;
    case BASE_ITEM_TWOBLADEDSWORD: nResult=1; break;
    case BASE_ITEM_WHIP: nResult=1; break;

    //Throwing Ranged - Comment out if unwanted
    case BASE_ITEM_THROWINGAXE: nResult=1; break;
    case BASE_ITEM_SHURIKEN: nResult=1; break;
    case BASE_ITEM_DART: nResult=1; break;

    //CEP Special
    case 309: nResult=1; break; //Assassin Dagger
    case 321: nResult=1; break; //Double Scimitar
    case 305: nResult=1; break; //Falchion1
    case 316: nResult=1; break; //Falchion2
    case 322: nResult=1; break; //Goad
    case 301: nResult=1; break; //Heavy Pick
    case 310: nResult=1; break; //Katar
    case 313: nResult=1; break; //Kukri2
    case 302: nResult=1; break; //Light Pick
    case 320: nResult=1; break; //Mercurial Greatsword
    case 319: nResult=1; break; //Mercurial Longsword
    case 303: nResult=1; break; //Sai
    case 300: nResult=1; break; //Trident 1H
    case 323: nResult=1; break; //WindFire Wheel
  }
return nResult;
}

int GetBludge(object oItem)
{ int nResult = 0;
  int nCheck = GetBaseItemType(oItem);
  switch(nCheck)
  { case BASE_ITEM_CLUB:  nResult=1; break;
    case BASE_ITEM_DIREMACE:  nResult=1; break;
    case BASE_ITEM_HEAVYFLAIL:  nResult=1; break;
    case BASE_ITEM_LIGHTHAMMER:  nResult=1; break;
    case BASE_ITEM_LIGHTMACE:  nResult=1; break;
    case BASE_ITEM_LIGHTFLAIL:  nResult=1; break;
    case BASE_ITEM_MORNINGSTAR:  nResult=1; break;
    case BASE_ITEM_QUARTERSTAFF:  nResult=1; break;
    case BASE_ITEM_WARHAMMER:  nResult=1; break;

    //CEP
    case 304: nResult=1; break; //Nunchaku
    case 308: nResult=1; break; //Sap
    case 312: nResult=1; break; //LightMace2
    case 317: nResult=1; break; //Heavy Mace
    case 318: nResult=1; break; //Maul
  }
return nResult;
}

int WeapDamageBonus(int nSongStrength)
{ int nResult = IP_CONST_DAMAGEBONUS_1;
  switch(nSongStrength)
  { case 2: nResult = IP_CONST_DAMAGEBONUS_2; break;
    case 3: nResult = IP_CONST_DAMAGEBONUS_1d4; break;
    case 4: nResult = IP_CONST_DAMAGEBONUS_3; break;
    case 5: nResult = IP_CONST_DAMAGEBONUS_1d6; break;
    case 6: nResult = IP_CONST_DAMAGEBONUS_4; break;
    case 7: nResult = IP_CONST_DAMAGEBONUS_1d8; break;
    case 8: nResult = IP_CONST_DAMAGEBONUS_2d4; break;
    case 9: nResult = IP_CONST_DAMAGEBONUS_5; break;
    case 10: nResult = IP_CONST_DAMAGEBONUS_1d10; break;
    case 11: nResult = IP_CONST_DAMAGEBONUS_1d12; break;
    case 12: nResult = IP_CONST_DAMAGEBONUS_2d6; break;
    case 13: nResult = IP_CONST_DAMAGEBONUS_6; break;
    case 14: nResult = IP_CONST_DAMAGEBONUS_7; break;
    case 15: nResult = IP_CONST_DAMAGEBONUS_2d8; break;
    case 16: nResult = IP_CONST_DAMAGEBONUS_8; break;
    case 17: nResult = IP_CONST_DAMAGEBONUS_9; break;
    case 18: nResult = IP_CONST_DAMAGEBONUS_2d10; break;
    case 19: nResult = IP_CONST_DAMAGEBONUS_10; break;
    case 20: nResult = IP_CONST_DAMAGEBONUS_2d12; break;
    case 21: nResult = IP_CONST_DAMAGEBONUS_2d12; break;
    case 22: nResult = IP_CONST_DAMAGEBONUS_2d12; break;
    case 23: nResult = IP_CONST_DAMAGEBONUS_2d12; break;
  }
  return nResult;
}

//////////////////////////////////////////////////

//Default Bioware Bardsong
void SongInspire(object oPC, int nSongStrength, int nDuration)
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

  effect eAttack = EffectAttackIncrease(nAttack);
  effect eDamage = EffectDamageIncrease(nDamage, DAMAGE_TYPE_BLUDGEONING);
  effect eWill, eFort, eReflex, eHP, eAC, eSkill;
  effect eLink = EffectLinkEffects(eAttack, eDamage);
  if(nWill > 0)
  { eWill = EffectSavingThrowIncrease(SAVING_THROW_WILL, nWill);
    eLink = EffectLinkEffects(eLink, eWill);
  }
  if(nFort > 0)
  { eFort = EffectSavingThrowIncrease(SAVING_THROW_FORT, nFort);
    eLink = EffectLinkEffects(eLink, eFort);
  }
  if(nReflex > 0)
  { eReflex = EffectSavingThrowIncrease(SAVING_THROW_REFLEX, nReflex);
    eLink = EffectLinkEffects(eLink, eReflex);
  }
  if(nHP > 0) eHP = EffectTemporaryHitpoints(nHP);
  if(nAC > 0)
  { eAC = EffectACIncrease(nAC, AC_DODGE_BONUS);
    eLink = EffectLinkEffects(eLink, eAC);
  }
  if(nSkill > 0)
  { eSkill = EffectSkillIncrease(SKILL_ALL_SKILLS, nSkill);
    eLink = EffectLinkEffects(eLink, eSkill);
  }
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
  eLink = EffectLinkEffects(eLink, eDur);
  eHP = ExtraordinaryEffect(eHP);
  eLink = ExtraordinaryEffect(eLink);

  effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_SONIC);
  effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);

  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  while(GetIsObjectValid(oTarget))
  { if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
    { // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
      if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(oTarget == oPC)
        { effect eLinkBard = EffectLinkEffects(eLink, eVis);
          eLinkBard = ExtraordinaryEffect(eLinkBard);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLinkBard, oTarget, RoundsToSeconds(nDuration));
          if (nHP > 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, RoundsToSeconds(nDuration));
        }
        else if(GetIsFriend(oTarget))
        { ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
          if (nHP > 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, RoundsToSeconds(nDuration));
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
}

void SongSharp(object oPC, int nSongStrength, int nDuration)
{ itemproperty iKeen = ItemPropertyKeen();

  effect eImpact = EffectVisualEffect(46);
  effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);
  effect eVis2 = EffectVisualEffect(VFX_DUR_CESSATE_NEUTRAL);
  eVis = EffectLinkEffects(eVis, eVis2);
  eVis = ExtraordinaryEffect(eVis);
  eVis2 = ExtraordinaryEffect(eVis2);

  //Define Vars Here
  object oWeapon, oOffhand;

  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  while(GetIsObjectValid(oTarget) && nSongStrength>0)
  { if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
    { // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
      if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(oTarget == oPC)
        { ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, RoundsToSeconds(nDuration));
          //Bonus Here
          oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
          oOffhand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
          if(GetIsObjectValid(oWeapon) && GetPierceSlash(oWeapon))
          { IPSafeAddItemProperty(oWeapon, iKeen, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
            nSongStrength--;
            if(GetIsPC(oTarget)) SendMessageToPC(oTarget, "Your "+GetName(oWeapon)+" resonates with the music.");
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          }
          if(GetIsObjectValid(oOffhand) && GetPierceSlash(oWeapon))
          { IPSafeAddItemProperty(oOffhand, iKeen, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
            nSongStrength--;
          }
        }
        else if(GetIsFriend(oTarget))
        { ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          //Bonus Here
          oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
          oOffhand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
          if(GetIsObjectValid(oWeapon) && GetPierceSlash(oWeapon))
          { ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget, RoundsToSeconds(nDuration));
            IPSafeAddItemProperty(oWeapon, iKeen, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
            nSongStrength--;
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
            if(GetIsPC(oTarget)) SendMessageToPC(oTarget, "Your "+GetName(oWeapon)+" resonates with the music.");
          }
          if(GetIsObjectValid(oOffhand) && GetPierceSlash(oWeapon))
          { IPSafeAddItemProperty(oWeapon, iKeen, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
            nSongStrength--;
          }
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
}

void SongCrescendo(object oPC, int nSongStrength, int nDuration)
{ effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
  effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);

  if(nDuration>20) nDuration = 6;
  else if(nDuration>10) nDuration = 3;
  else nDuration = 2;

  int nCount = GetLocalInt(oPC, "CRESCENDOCOUNT");
  if(nCount==0)
  { SetLocalInt(oPC, "CRESCENDOCOUNT", 1);
    DelayCommand(RoundsToSeconds(nDuration*nSongStrength), DeleteLocalInt(oPC, "CRESCENDOCOUNT"));
    nCount++;
  }
  else
  { nCount++;
    SetLocalInt(oPC, "CRESCENDOCOUNT", nCount);
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
    DeleteLocalInt(oPC, "CRESCENDOCOUNT");
    effect eSilence = EffectSilence();
    effect eVis2 = EffectVisualEffect(VFX_DUR_CESSATE_NEUTRAL);
    eSilence = EffectLinkEffects(eSilence, eVis2);
    eSilence = ExtraordinaryEffect(eSilence);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSilence, oPC, RoundsToSeconds(nDuration*5));
    return;
  }
  else
  { FloatingTextStringOnCreature(GetName(oPC)+" raises "+sPronoun+" song's pitch to "+IntToString(nCount)+"!", oPC, FALSE);
  }

  //Bonuses Here
  effect eAttack = EffectAttackIncrease(nCount);
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
  eAttack = EffectLinkEffects(eAttack, eDur);
  eAttack = ExtraordinaryEffect(eAttack);

  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  while(GetIsObjectValid(oTarget))
  { if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
    { // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
      if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(oTarget == oPC)
        { //Bonus Here
          effect eBardLinked = EffectLinkEffects(eAttack, eVis);
          eBardLinked = ExtraordinaryEffect(eBardLinked);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBardLinked, oTarget, RoundsToSeconds(nDuration));
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
        }
        else if(GetIsFriend(oTarget))
        { ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          //Bonus Here
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttack, oTarget, RoundsToSeconds(nDuration));
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
}

void SongAllegro(object oPC, int nSongStrength, int nDuration)
{ effect eImpact = EffectVisualEffect(VFX_IMP_HASTE);
  effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);

  //Bonuses Here
  effect eHaste = EffectMovementSpeedIncrease(10+5*nSongStrength);
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
  eHaste = EffectLinkEffects(eHaste, eDur);
  eHaste = ExtraordinaryEffect(eHaste);

  //Define Vars Here

  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  while(GetIsObjectValid(oTarget))
  { if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
    { // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
      if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(oTarget == oPC)
        { //Bonus Here
          if(!GetHasSpellEffect(SPELL_HASTE, oTarget))
          { effect eBardLinked = EffectLinkEffects(eHaste, eVis);
            eBardLinked = ExtraordinaryEffect(eBardLinked);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBardLinked, oTarget, RoundsToSeconds(nDuration));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          }
          else
          { eVis = ExtraordinaryEffect(eVis);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, RoundsToSeconds(nDuration));
          }
        }
        else if(GetIsFriend(oTarget) && !GetHasSpellEffect(SPELL_HASTE, oTarget))
        { ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          //Bonus Here
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHaste, oTarget, RoundsToSeconds(nDuration));
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
}

void SongHymn(object oPC, int nSongStrength, int nDuration)
{ effect eImpact = EffectVisualEffect(VFX_IMP_GOOD_HELP);
  effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);

  //Bonuses Here
  int nAC = 0;
  if(nSongStrength>=4) nAC = nSongStrength-3;
  else
  { FloatingTextStringOnCreature("You try to sing the song, but the words tangle in your mouth.", oPC);
    return;
  }
  effect eAC;
  if(nAC>4) eAC = EffectACIncrease(nAC, AC_DEFLECTION_BONUS);
  else if(nAC>0)  eAC = EffectACIncrease(nAC, AC_DODGE_BONUS);
  eAC = VersusAlignmentEffect(eAC,ALIGNMENT_ALL, ALIGNMENT_EVIL);

  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
  eAC = EffectLinkEffects(eAC, eDur);
  eAC = ExtraordinaryEffect(eAC);

  //Define Vars Here

  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  while(GetIsObjectValid(oTarget))
  { if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
    { // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
      if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(oTarget == oPC)
        { //Bonus Here
          effect eBardLinked = EffectLinkEffects(eAC, eVis);
          eBardLinked = ExtraordinaryEffect(eBardLinked);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBardLinked, oTarget, RoundsToSeconds(nDuration));
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
        }
        else if(GetIsFriend(oTarget) && GetAlignmentGoodEvil(oTarget)==ALIGNMENT_GOOD)
        { ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          //Bonus Here
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, oTarget, RoundsToSeconds(nDuration));
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
}

void SongThrenody(object oPC, int nSongStrength, int nDuration)
{ effect eImpact = EffectVisualEffect(VFX_IMP_EVIL_HELP);
  effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);

  //Bonuses Here
  int nAC = 0;
  if(nSongStrength>=4) nAC = nSongStrength-3;
  else
  { FloatingTextStringOnCreature("You try to sing the song, but the words tangle in your mouth.", oPC);
    return;
  }
  effect eAC;
  if(nAC>4) eAC = EffectACIncrease(nAC, AC_DEFLECTION_BONUS);
  else if(nAC>0)  eAC = EffectACIncrease(nAC, AC_DODGE_BONUS);
  eAC = VersusAlignmentEffect(eAC,ALIGNMENT_ALL, ALIGNMENT_GOOD);

  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
  eAC = EffectLinkEffects(eAC, eDur);
  eAC = ExtraordinaryEffect(eAC);

  //Define Vars Here

  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  while(GetIsObjectValid(oTarget))
  { if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
    { // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
      if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(oTarget == oPC)
        { //Bonus Here
          effect eBardLinked = EffectLinkEffects(eAC, eVis);
          eBardLinked = ExtraordinaryEffect(eBardLinked);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBardLinked, oTarget, RoundsToSeconds(nDuration));
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
        }
        else if(GetIsFriend(oTarget) && GetAlignmentGoodEvil(oTarget)==ALIGNMENT_EVIL)
        { ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          //Bonus Here
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAC, oTarget, RoundsToSeconds(nDuration));
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
}

void SongRage(object oPC)
{ effect eImpact = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
  effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);

  //Bonuses Here
  int nSave = 2;
  int nIncrease = 4;

  effect eStr = EffectAbilityIncrease(ABILITY_CONSTITUTION, nIncrease);
  effect eCon = EffectAbilityIncrease(ABILITY_STRENGTH, nIncrease);
  effect eSave = EffectSavingThrowIncrease(SAVING_THROW_WILL, nSave);
  effect eAC = EffectACDecrease(2, AC_DODGE_BONUS);

  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
  effect eLink = EffectLinkEffects(eCon, eStr);
  eLink = EffectLinkEffects(eLink, eSave);
  eLink = EffectLinkEffects(eLink, eAC);
  eLink = EffectLinkEffects(eLink, eDur);
  eLink = ExtraordinaryEffect(eLink);

  int nCon;

  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  while(GetIsObjectValid(oTarget))
  { if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
    { // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
      if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(oTarget == oPC)
        { //Bonus Here
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, RoundsToSeconds(10));
        }
        else if(GetIsFriend(oTarget))
        { ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          //Bonus Here
          nCon = 5 + GetAbilityModifier(ABILITY_CONSTITUTION, oTarget);
          if(nCon>10) nCon = 10;
          AssignCommand(oTarget, PlayVoiceChat(VOICE_CHAT_BATTLECRY1));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nCon));
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
}

void SongEleWeap(object oPC, int nSongStrength, int nDuration, int nType = IP_CONST_DAMAGETYPE_FIRE)
{ int nBonus;
  if(nSongStrength<23) nBonus = WeapDamageBonus(nSongStrength/2);
  else nBonus = WeapDamageBonus(12);

  itemproperty iKeen = ItemPropertyDamageBonus(nType, nBonus);

  effect eImpact = EffectVisualEffect(46);
  effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);
  effect eVis2 = EffectVisualEffect(VFX_DUR_CESSATE_NEUTRAL);
  eVis = EffectLinkEffects(eVis, eVis2);
  eVis = ExtraordinaryEffect(eVis);
  eVis2 = ExtraordinaryEffect(eVis2);

  //Define Vars Here
  object oWeapon, oOffhand;

  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  while(GetIsObjectValid(oTarget))
  { if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
    { // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
      if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(oTarget == oPC)
        { ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, RoundsToSeconds(nDuration));
          //Bonus Here
          oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
          oOffhand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
          if(GetIsObjectValid(oWeapon))
          { IPSafeAddItemProperty(oWeapon, iKeen, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
            if(GetIsPC(oTarget)) SendMessageToPC(oTarget, "Your "+GetName(oWeapon)+" resonates with the music.");
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          }
          if(GetIsObjectValid(oOffhand))
          { IPSafeAddItemProperty(oOffhand, iKeen, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
          }
        }
        else if(GetIsFriend(oTarget))
        { ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          //Bonus Here
          oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
          oOffhand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
          if(GetIsObjectValid(oWeapon))
          { ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget, RoundsToSeconds(nDuration));
            IPSafeAddItemProperty(oWeapon, iKeen, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
            if(GetIsPC(oTarget)) SendMessageToPC(oTarget, "Your "+GetName(oWeapon)+" resonates with the music.");
          }
          if(GetIsObjectValid(oOffhand))
          { IPSafeAddItemProperty(oWeapon, iKeen, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
          }
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
}

void SongEleDef(object oPC, int nSongStrength, int nDuration, int nType = DAMAGE_TYPE_SONIC, int nVFX = VFX_IMP_HEAD_SONIC)
{ int nBonus = 2*nSongStrength +6; //+2% Per Level
  if(nSongStrength>=13) nBonus = nBonus + nSongStrength-12; //+3% Per Level after 20
  if(nSongStrength>=18) nBonus = nBonus + nSongStrength-17; //+4% Per Level after 25
  if(nSongStrength>=23) nBonus = nBonus + 1;                //+5% Per Level at 30 (70% Total Bonus)

  effect eImpact = EffectVisualEffect(nVFX);
  effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);

  //Bonuses Here
  effect eBonus = EffectDamageImmunityIncrease(nType, nBonus);
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEUTRAL);
  eBonus = EffectLinkEffects(eBonus, eDur);
  eBonus = ExtraordinaryEffect(eBonus);

  //Define Vars Here

  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  while(GetIsObjectValid(oTarget))
  { if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
    { // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
      if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(oTarget == oPC)
        { //Bonus Here
          effect eBardLinked = EffectLinkEffects(eBonus, eVis);
          eBardLinked = ExtraordinaryEffect(eBardLinked);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBardLinked, oTarget, RoundsToSeconds(nDuration));
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
        }
        else if(GetIsFriend(oTarget))
        { ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          //Bonus Here
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBonus, oTarget, RoundsToSeconds(nDuration));
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
}

void SongRegen(object oPC, int nSongStrength, int nDuration)
{ effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_HEAL);
  effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);

  int nHealBonus = GetSkillRank(SKILL_HEAL); //Heal Skill bonus 1HP per 5 skill
  if(nHealBonus>=5) nHealBonus=nHealBonus/5;
  else nHealBonus = 0;

  if(nHealBonus>nSongStrength) nHealBonus=nSongStrength; //HealSkill cannot exceed songlevel

  //Bonuses Here
  effect eBonus = EffectRegenerate(1+nHealBonus+(nSongStrength/2), 6.0);
  effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
  eBonus = EffectLinkEffects(eBonus, eDur);
  eBonus = ExtraordinaryEffect(eBonus);

  //Define Vars Here

  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  while(GetIsObjectValid(oTarget))
  { if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
    { // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
      if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(oTarget == oPC)
        { //Bonus Here
          effect eBardLinked = EffectLinkEffects(eBonus, eVis);
          eBardLinked = ExtraordinaryEffect(eBardLinked);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBardLinked, oTarget, RoundsToSeconds(nDuration));
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
        }
        else if(GetIsFriend(oTarget))
        { ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          //Bonus Here
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBonus, oTarget, RoundsToSeconds(nDuration));
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
}

void SongBrawl(object oPC, int nSongStrength, int nDuration)
{ int nBonus = WeapDamageBonus(nSongStrength);

  itemproperty iKeen = ItemPropertyMassiveCritical(nBonus);
  nBonus = WeapDamageBonus(1+nSongStrength/2);
  itemproperty iGlove = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING, nBonus);

  effect eImpact = EffectVisualEffect(46);
  effect eVis = EffectVisualEffect(VFX_DUR_BARD_SONG);
  eVis = ExtraordinaryEffect(eVis);

  //Define Vars Here
  object oWeapon, oOffhand;

  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  while(GetIsObjectValid(oTarget))
  { if(!GetHasFeatEffect(FEAT_BARD_SONGS, oTarget) && !GetHasSpellEffect(GetSpellId(),oTarget))
    { // * GZ Oct 2003: If we are silenced, we can not benefit from bard song
      if (!GetHasEffect(EFFECT_TYPE_SILENCE,oTarget) && !GetHasEffect(EFFECT_TYPE_DEAF,oTarget))
      { if(oTarget == oPC)
        { ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, RoundsToSeconds(nDuration));
          //Bonus Here
          oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
          oOffhand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
          if(GetIsObjectValid(oWeapon) && GetBludge(oWeapon))
          { IPSafeAddItemProperty(oWeapon, iKeen, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
            if(GetIsPC(oTarget)) SendMessageToPC(oTarget, "Your "+GetName(oWeapon)+" resonates with the music.");
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          }
          else
          { oWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget);
            if(GetBaseItemType(oWeapon)==BASE_ITEM_GLOVES)
            { IPSafeAddItemProperty(oWeapon, iGlove, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
              if(GetIsPC(oTarget)) SendMessageToPC(oTarget, "Your fists feel empowered with the music.");
            }
          }
          if(GetIsObjectValid(oOffhand) && GetBludge(oWeapon))
          { IPSafeAddItemProperty(oOffhand, iKeen, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
          }
        }
        else if(GetIsFriend(oTarget))
        { ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
          //Bonus Here
          oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
          oOffhand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);
          if(GetIsObjectValid(oWeapon) && GetBludge(oWeapon))
          { IPSafeAddItemProperty(oWeapon, iKeen, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
            if(GetIsPC(oTarget)) SendMessageToPC(oTarget, "Your "+GetName(oWeapon)+" resonates with the music.");
          }
          else
          { oWeapon = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget);
            if(GetBaseItemType(oWeapon)==BASE_ITEM_GLOVES)
            { IPSafeAddItemProperty(oWeapon, iGlove, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
              ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
              if(GetIsPC(oTarget)) SendMessageToPC(oTarget, "Your fists feel empowered with the music.");
            }
          }
          if(GetIsObjectValid(oOffhand) && GetBludge(oWeapon))
          { IPSafeAddItemProperty(oWeapon, iKeen, RoundsToSeconds(nDuration), X2_IP_ADDPROP_POLICY_KEEP_EXISTING);
          }
        }
      }
    }
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(oPC));
  }
}
