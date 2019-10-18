////////////////////////////////////////////////////////////////////////
// Written by Scarss and Etched In Blood                              //
//                                                                    //
//                                                                    //
// Sector 1 = Definitions of all effects                              //
// Sector 2 = Application of Karubi effects                           //                                        //
// Sector 3 = Application of Loxxan effects                           //                                        //
// Sector 4 = Application of Episidies effects                        //                                        //
// Sector 5 = Application of Culan effects                            //                                        //
//                                                                    //
// You can search for a sector and be brought directly to it!         //
////////////////////////////////////////////////////////////////////////





#include "NW_I0_GENERIC"
object oPC =  GetPCSpeaker();
void main()
{
int nLocked=FALSE;
string sSound = "as_an_wolfhowl2";
PlaySound(sSound);
object oTarget;
oTarget = oPC;
effect eEffect;
eEffect = EffectCutsceneImmobilize();
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 4.0f);
ActionPlayAnimation(ANIMATION_LOOPING_SPASM ,2.0, 3.0);
PlayVoiceChat(VOICE_CHAT_PAIN1, oPC);
effect oVis = EffectVisualEffect(VFX_COM_BLOOD_CRT_RED);
string s1 =  GetPCPlayerName(oPC);
//Shifting message.
string s2 = "You feel your bones shift as you change into Crinos form.";
int aWill = GetWillSavingThrow(oPC);
EffectSavingThrowDecrease(SAVING_THROW_WILL, 5, SAVING_THROW_TYPE_MIND_SPELLS);

//Removes equiped items.
object aItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
object bItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
object cItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
object dItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC);
object eItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC);
object fItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
object gItem = GetItemInSlot(INVENTORY_SLOT_BELT, oPC);

ActionUnequipItem(aItem);
ActionUnequipItem(bItem);
ActionUnequipItem(cItem);
ActionUnequipItem(dItem);
ActionUnequipItem(eItem);
ActionUnequipItem(fItem);
ActionUnequipItem(gItem);

//Sets variable so conversation knows a form is activated.
   SetLocalInt(oPC, "wolf_form", 1);

//Shifting visuals
effect nVis = EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR);
effect lVis = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE);

//Apply the change visuals.
   ApplyEffectToObject(DURATION_TYPE_INSTANT, oVis, oPC);
   DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, lVis, oPC));
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, nVis, oPC, 3.0);
   FloatingTextStringOnCreature(s2, oPC);


/////////////////////////////////////
//////////// SECTOR 1 ///////////////
/////////////////////////////////////

//// MOVEMENT SPEED INCREASES ////

effect aMove = EffectMovementSpeedIncrease(05);
       aMove = SupernaturalEffect(aMove);
effect bMove = EffectMovementSpeedIncrease(05);
       bMove = SupernaturalEffect(bMove);
effect cMove = EffectMovementSpeedIncrease(10);
       cMove = SupernaturalEffect(cMove);
effect dMove = EffectMovementSpeedIncrease(12);
       dMove = SupernaturalEffect(dMove);
effect eMove = EffectMovementSpeedIncrease(15);
       eMove = SupernaturalEffect(eMove);
effect fMove = EffectMovementSpeedIncrease(17);
       fMove = SupernaturalEffect(fMove);
effect gMove = EffectMovementSpeedIncrease(20);
       gMove = SupernaturalEffect(gMove);
effect hMove = EffectMovementSpeedIncrease(22);
       hMove = SupernaturalEffect(hMove);
effect iMove = EffectMovementSpeedIncrease(25);
       iMove = SupernaturalEffect(iMove);
effect jMove = EffectMovementSpeedIncrease(27);
       jMove = SupernaturalEffect(jMove);
effect kMove = EffectMovementSpeedIncrease(30);
       kMove = SupernaturalEffect(kMove);
effect lMove = EffectMovementSpeedIncrease(32);
       lMove = SupernaturalEffect(lMove);
effect mMove = EffectMovementSpeedIncrease(35);
       mMove = SupernaturalEffect(mMove);
effect nMove = EffectMovementSpeedIncrease(37);
       nMove = SupernaturalEffect(nMove);
effect oMove = EffectMovementSpeedIncrease(40);
       oMove = SupernaturalEffect(oMove);
effect pMove = EffectMovementSpeedIncrease(42);
       pMove = SupernaturalEffect(pMove);
effect qMove = EffectMovementSpeedIncrease(44);
       qMove = SupernaturalEffect(qMove);
effect rMove = EffectMovementSpeedIncrease(46);
       rMove = SupernaturalEffect(rMove);
effect sMove = EffectMovementSpeedIncrease(48);
       sMove = SupernaturalEffect(sMove);
effect tMove = EffectMovementSpeedIncrease(50);
       tMove = SupernaturalEffect(tMove);

//// STRENGTH INCREASES ////

effect aAbility = EffectAbilityIncrease(ABILITY_STRENGTH, 2);
       aAbility = SupernaturalEffect(aAbility);
effect bAbility = EffectAbilityIncrease(ABILITY_STRENGTH, 3);
       bAbility = SupernaturalEffect(bAbility);
effect cAbility = EffectAbilityIncrease(ABILITY_STRENGTH, 3);
       cAbility = SupernaturalEffect(cAbility);
effect dAbility = EffectAbilityIncrease(ABILITY_STRENGTH, 4);
       dAbility = SupernaturalEffect(dAbility);
effect eAbility = EffectAbilityIncrease(ABILITY_STRENGTH, 5);
       eAbility = SupernaturalEffect(eAbility);
effect fAbility = EffectAbilityIncrease(ABILITY_STRENGTH, 6);
       fAbility = SupernaturalEffect(fAbility);
effect gAbility = EffectAbilityIncrease(ABILITY_STRENGTH, 7);
       gAbility = SupernaturalEffect(gAbility);
effect hAbility = EffectAbilityIncrease(ABILITY_STRENGTH, 8);
       hAbility = SupernaturalEffect(hAbility);
effect iAbility = EffectAbilityIncrease(ABILITY_STRENGTH, 9);
       iAbility = SupernaturalEffect(iAbility);
effect jAbility = EffectAbilityIncrease(ABILITY_STRENGTH, 10);
       jAbility = SupernaturalEffect(jAbility);
effect kAbility = EffectAbilityIncrease(ABILITY_STRENGTH, 11);
       kAbility = SupernaturalEffect(kAbility);
effect lAbility = EffectAbilityIncrease(ABILITY_STRENGTH, 12);
       lAbility = SupernaturalEffect(lAbility);

//// CHARISMA DECREASES ////

effect baAbility = EffectAbilityDecrease(ABILITY_CHARISMA, 2);
       baAbility = SupernaturalEffect(baAbility);
effect bbAbility = EffectAbilityDecrease(ABILITY_CHARISMA, 2);
       bbAbility = SupernaturalEffect(bbAbility);
effect bcAbility = EffectAbilityDecrease(ABILITY_CHARISMA, 3);
       bcAbility = SupernaturalEffect(bcAbility);
effect bdAbility = EffectAbilityDecrease(ABILITY_CHARISMA, 4);
       bdAbility = SupernaturalEffect(bdAbility);
effect beAbility = EffectAbilityDecrease(ABILITY_CHARISMA, 5);
       beAbility = SupernaturalEffect(beAbility);
effect bfAbility = EffectAbilityDecrease(ABILITY_CHARISMA, 6);
       bfAbility = SupernaturalEffect(bfAbility);
effect bgAbility = EffectAbilityDecrease(ABILITY_CHARISMA, 7);
       bgAbility = SupernaturalEffect(bgAbility);
effect bhAbility = EffectAbilityDecrease(ABILITY_CHARISMA, 8);
       bhAbility = SupernaturalEffect(bhAbility);
effect biAbility = EffectAbilityDecrease(ABILITY_CHARISMA, 9);
       biAbility = SupernaturalEffect(biAbility);
effect bjAbility = EffectAbilityDecrease(ABILITY_CHARISMA, 10);
       bjAbility = SupernaturalEffect(bjAbility);
effect bkAbility = EffectAbilityDecrease(ABILITY_CHARISMA, 11);
       bkAbility = SupernaturalEffect(bkAbility);
effect blAbility = EffectAbilityDecrease(ABILITY_CHARISMA, 12);
       blAbility = SupernaturalEffect(blAbility);

//// DEXTERITY INCREASES ////

effect caAbility = EffectAbilityIncrease(ABILITY_DEXTERITY, 2);
       caAbility = SupernaturalEffect(caAbility);
effect cbAbility = EffectAbilityIncrease(ABILITY_DEXTERITY, 2);
       cbAbility = SupernaturalEffect(cbAbility);
effect ccAbility = EffectAbilityIncrease(ABILITY_DEXTERITY, 3);
       ccAbility = SupernaturalEffect(ccAbility);
effect cdAbility = EffectAbilityIncrease(ABILITY_DEXTERITY, 4);
       cdAbility = SupernaturalEffect(cdAbility);
effect ceAbility = EffectAbilityIncrease(ABILITY_DEXTERITY, 5);
       ceAbility = SupernaturalEffect(ceAbility);
effect cfAbility = EffectAbilityIncrease(ABILITY_DEXTERITY, 6);
       cfAbility = SupernaturalEffect(cfAbility);
effect cgAbility = EffectAbilityIncrease(ABILITY_DEXTERITY, 7);
       cgAbility = SupernaturalEffect(cgAbility);
effect chAbility = EffectAbilityIncrease(ABILITY_DEXTERITY, 8);
       chAbility = SupernaturalEffect(chAbility);
effect ciAbility = EffectAbilityIncrease(ABILITY_DEXTERITY, 9);
       ciAbility = SupernaturalEffect(ciAbility);
effect cjAbility = EffectAbilityIncrease(ABILITY_DEXTERITY, 10);
       cjAbility = SupernaturalEffect(cjAbility);
effect ckAbility = EffectAbilityIncrease(ABILITY_DEXTERITY, 11);
       ckAbility = SupernaturalEffect(ckAbility);
effect clAbility = EffectAbilityIncrease(ABILITY_DEXTERITY, 12);
       clAbility = SupernaturalEffect(clAbility);

//// CONSTITUTION INCREASES ////

effect daAbility = EffectAbilityIncrease(ABILITY_CONSTITUTION, 2);
       daAbility = SupernaturalEffect(daAbility);
effect dbAbility = EffectAbilityIncrease(ABILITY_CONSTITUTION, 2);
       dbAbility = SupernaturalEffect(dbAbility);
effect dcAbility = EffectAbilityIncrease(ABILITY_CONSTITUTION, 3);
       dcAbility = SupernaturalEffect(dcAbility);
effect ddAbility = EffectAbilityIncrease(ABILITY_CONSTITUTION, 4);
       ddAbility = SupernaturalEffect(ddAbility);
effect deAbility = EffectAbilityIncrease(ABILITY_CONSTITUTION, 5);
       deAbility = SupernaturalEffect(deAbility);
effect dfAbility = EffectAbilityIncrease(ABILITY_CONSTITUTION, 6);
       dfAbility = SupernaturalEffect(dfAbility);
effect dgAbility = EffectAbilityIncrease(ABILITY_CONSTITUTION, 7);
       dgAbility = SupernaturalEffect(dgAbility);
effect dhAbility = EffectAbilityIncrease(ABILITY_CONSTITUTION, 8);
       dhAbility = SupernaturalEffect(dhAbility);
effect diAbility = EffectAbilityIncrease(ABILITY_CONSTITUTION, 9);
       diAbility = SupernaturalEffect(diAbility);
effect djAbility = EffectAbilityIncrease(ABILITY_CONSTITUTION, 10);
       djAbility = SupernaturalEffect(djAbility);
effect dkAbility = EffectAbilityIncrease(ABILITY_CONSTITUTION, 11);
       dkAbility = SupernaturalEffect(dkAbility);
effect dlAbility = EffectAbilityIncrease(ABILITY_CONSTITUTION, 12);
       dlAbility = SupernaturalEffect(dlAbility);

//// DAMAGE REDUCTION ////

effect aReduce = EffectDamageReduction(5, DAMAGE_POWER_PLUS_ONE, 0);
       aReduce = SupernaturalEffect(aReduce);
effect bReduce = EffectDamageReduction(10, DAMAGE_POWER_PLUS_ONE, 0);
       bReduce = SupernaturalEffect(bReduce);
effect cReduce = EffectDamageReduction(15, DAMAGE_POWER_PLUS_ONE, 0);
       cReduce = SupernaturalEffect(cReduce);
effect dReduce = EffectDamageReduction(20, DAMAGE_POWER_PLUS_ONE, 0);
       dReduce = SupernaturalEffect(dReduce);

//// REGENERATION ////

effect aRegen =  EffectRegenerate(2, 3.0);
       aRegen = SupernaturalEffect(aRegen);
effect bRegen =  EffectRegenerate(3, 3.0);
       bRegen = SupernaturalEffect(bRegen);
effect cRegen =  EffectRegenerate(4, 3.0);
       cRegen = SupernaturalEffect(cRegen);
effect dRegen =  EffectRegenerate(4, 3.0);
       dRegen = SupernaturalEffect(dRegen);
effect eRegen =  EffectRegenerate(5, 3.0);
       eRegen = SupernaturalEffect(eRegen);
effect fRegen =  EffectRegenerate(5, 3.0);
       fRegen = SupernaturalEffect(fRegen);
effect gRegen =  EffectRegenerate(6, 3.0);
       gRegen = SupernaturalEffect(gRegen);
effect hRegen =  EffectRegenerate(6, 3.0);
       hRegen = SupernaturalEffect(hRegen);
effect iRegen =  EffectRegenerate(7, 2.0);
       iRegen = SupernaturalEffect(iRegen);
effect jRegen =  EffectRegenerate(7, 2.0);
       jRegen = SupernaturalEffect(jRegen);
effect kRegen =  EffectRegenerate(8, 2.0);
       kRegen = SupernaturalEffect(kRegen);
effect lRegen =  EffectRegenerate(8, 2.0);
       lRegen = SupernaturalEffect(lRegen);
effect mRegen =  EffectRegenerate(9, 2.0);
       mRegen = SupernaturalEffect(mRegen);
effect nRegen =  EffectRegenerate(9, 3.0);
       nRegen = SupernaturalEffect(nRegen);
effect oRegen =  EffectRegenerate(10, 1.0);
       oRegen = SupernaturalEffect(oRegen);
effect pRegen =  EffectRegenerate(10, 1.0);
       pRegen = SupernaturalEffect(pRegen);
effect qRegen =  EffectRegenerate(11, 1.0);
       qRegen = SupernaturalEffect(qRegen);
effect rRegen =  EffectRegenerate(11, 1.0);
       rRegen = SupernaturalEffect(rRegen);
effect sRegen =  EffectRegenerate(12, 1.0);
       sRegen = SupernaturalEffect(sRegen);


//// DAMAGE INCREASES ////

effect aDamage = EffectDamageIncrease(DAMAGE_BONUS_2, DAMAGE_TYPE_POSITIVE);
effect bDamage = EffectDamageIncrease(DAMAGE_BONUS_4, DAMAGE_TYPE_POSITIVE);
effect cDamage = EffectDamageIncrease(DAMAGE_BONUS_6, DAMAGE_TYPE_POSITIVE);
effect dDamage = EffectDamageIncrease(DAMAGE_BONUS_8, DAMAGE_TYPE_POSITIVE);
effect eDamage = EffectDamageIncrease(DAMAGE_BONUS_10, DAMAGE_TYPE_POSITIVE);
effect fDamage = EffectDamageIncrease(DAMAGE_BONUS_12, DAMAGE_TYPE_POSITIVE);
effect gDamage = EffectDamageIncrease(DAMAGE_BONUS_14, DAMAGE_TYPE_POSITIVE);
effect hDamage = EffectDamageIncrease(DAMAGE_BONUS_16, DAMAGE_TYPE_POSITIVE);
effect iDamage = EffectDamageIncrease(DAMAGE_BONUS_18, DAMAGE_TYPE_POSITIVE);
effect jDamage = EffectDamageIncrease(DAMAGE_BONUS_20, DAMAGE_TYPE_POSITIVE);
effect kDamage = EffectDamageIncrease(DAMAGE_BONUS_1d4, DAMAGE_TYPE_POSITIVE);
effect lDamage = EffectDamageIncrease(DAMAGE_BONUS_1d6, DAMAGE_TYPE_POSITIVE);
effect mDamage = EffectDamageIncrease(DAMAGE_BONUS_1d8, DAMAGE_TYPE_POSITIVE);
effect nDamage = EffectDamageIncrease(DAMAGE_BONUS_1d10, DAMAGE_TYPE_POSITIVE);
effect oDamage = EffectDamageIncrease(DAMAGE_BONUS_1d12, DAMAGE_TYPE_POSITIVE);
effect pDamage = EffectDamageIncrease(DAMAGE_BONUS_2d4, DAMAGE_TYPE_POSITIVE);
effect qDamage = EffectDamageIncrease(DAMAGE_BONUS_2d6, DAMAGE_TYPE_POSITIVE);
effect rDamage = EffectDamageIncrease(DAMAGE_BONUS_2d8, DAMAGE_TYPE_POSITIVE);
effect sDamage = EffectDamageIncrease(DAMAGE_BONUS_2d10, DAMAGE_TYPE_POSITIVE);
effect tDamage = EffectDamageIncrease(DAMAGE_BONUS_2d12, DAMAGE_TYPE_POSITIVE);

//// ARMOR CLASS INCREASES ////

effect aAC = EffectACIncrease(8);
effect bAC = EffectACIncrease(10);
effect cAC = EffectACIncrease(12);
effect dAC = EffectACIncrease(14);
effect eAC = EffectACIncrease(15);
effect fAC = EffectACIncrease(18);
effect gAC = EffectACIncrease(21);
effect hAC = EffectACIncrease(24);
effect iAC = EffectACIncrease(27);
effect jAC = EffectACIncrease(30);

//// SKILL INCREASE - HIDE ////

effect aaSkill = EffectSkillIncrease(SKILL_HIDE, 2);
       aaSkill = SupernaturalEffect(aaSkill);
effect abSkill = EffectSkillIncrease(SKILL_HIDE, 4);
       abSkill = SupernaturalEffect(abSkill);
effect acSkill = EffectSkillIncrease(SKILL_HIDE, 6);
       acSkill = SupernaturalEffect(acSkill);
effect adSkill = EffectSkillIncrease(SKILL_HIDE, 8);
       adSkill = SupernaturalEffect(adSkill);
effect aeSkill = EffectSkillIncrease(SKILL_HIDE, 10);
       aeSkill = SupernaturalEffect(aeSkill);
effect afSkill = EffectSkillIncrease(SKILL_HIDE, 12);
       afSkill = SupernaturalEffect(afSkill);
effect agSkill = EffectSkillIncrease(SKILL_HIDE, 14);
       agSkill = SupernaturalEffect(agSkill);
effect ahSkill = EffectSkillIncrease(SKILL_HIDE, 16);
       ahSkill = SupernaturalEffect(ahSkill);
effect aiSkill = EffectSkillIncrease(SKILL_HIDE, 18);
       aiSkill = SupernaturalEffect(aiSkill);
effect ajSkill = EffectSkillIncrease(SKILL_HIDE, 20);
       ajSkill = SupernaturalEffect(ajSkill);
effect akSkill = EffectSkillIncrease(SKILL_HIDE, 20);
       akSkill = SupernaturalEffect(akSkill);

//// SKILL INCREASE - MOVE SILENTLY ////

effect baSkill = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 2);
       baSkill = SupernaturalEffect(baSkill);
effect bbSkill = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 4);
       bbSkill = SupernaturalEffect(bbSkill);
effect bcSkill = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 6);
       bcSkill = SupernaturalEffect(bcSkill);
effect bdSkill = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 8);
       bdSkill = SupernaturalEffect(bdSkill);
effect beSkill = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 8);
       beSkill = SupernaturalEffect(beSkill);
effect bfSkill = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 10);
       bfSkill = SupernaturalEffect(bfSkill);
effect bgSkill = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 12);
       bgSkill = SupernaturalEffect(bgSkill);
effect bhSkill = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 14);
       bhSkill = SupernaturalEffect(bhSkill);
effect biSkill = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 16);
       biSkill = SupernaturalEffect(biSkill);
effect bjSkill = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 18);
       bjSkill = SupernaturalEffect(bjSkill);
effect bkSkill = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 20);
       bkSkill = SupernaturalEffect(bkSkill);

//// SKILL INCREASE - LISTEN ////

effect caSkill = EffectSkillIncrease(SKILL_LISTEN, 2);
       caSkill = SupernaturalEffect(caSkill);
effect cbSkill = EffectSkillIncrease(SKILL_LISTEN, 4);
       cbSkill = SupernaturalEffect(cbSkill);
effect ccSkill = EffectSkillIncrease(SKILL_LISTEN, 6);
       ccSkill = SupernaturalEffect(ccSkill);
effect cdSkill = EffectSkillIncrease(SKILL_LISTEN, 8);
       cdSkill = SupernaturalEffect(cdSkill);
effect ceSkill = EffectSkillIncrease(SKILL_LISTEN, 10);
       ceSkill = SupernaturalEffect(ceSkill);
effect cfSkill = EffectSkillIncrease(SKILL_LISTEN, 12);
       cfSkill = SupernaturalEffect(cfSkill);
effect cgSkill = EffectSkillIncrease(SKILL_LISTEN, 14);
       cgSkill = SupernaturalEffect(cgSkill);
effect chSkill = EffectSkillIncrease(SKILL_LISTEN, 16);
       chSkill = SupernaturalEffect(chSkill);
effect ciSkill = EffectSkillIncrease(SKILL_LISTEN, 18);
       ciSkill = SupernaturalEffect(ciSkill);
effect cjSkill = EffectSkillIncrease(SKILL_LISTEN, 20);
       cjSkill = SupernaturalEffect(cjSkill);
effect ckSkill = EffectSkillIncrease(SKILL_LISTEN, 20);
       ckSkill = SupernaturalEffect(ckSkill);

//// SKILL INCREASE - SEARCH ////

effect daSkill = EffectSkillIncrease(SKILL_SEARCH, 2);
       daSkill = SupernaturalEffect(daSkill);
effect dbSkill = EffectSkillIncrease(SKILL_SEARCH, 4);
       dbSkill = SupernaturalEffect(dbSkill);
effect dcSkill = EffectSkillIncrease(SKILL_SEARCH, 6);
       dcSkill = SupernaturalEffect(dcSkill);
effect ddSkill = EffectSkillIncrease(SKILL_SEARCH, 8);
       ddSkill = SupernaturalEffect(ddSkill);
effect deSkill = EffectSkillIncrease(SKILL_SEARCH, 10);
       deSkill = SupernaturalEffect(deSkill);
effect dfSkill = EffectSkillIncrease(SKILL_SEARCH, 12);
       dfSkill = SupernaturalEffect(dfSkill);
effect dgSkill = EffectSkillIncrease(SKILL_SEARCH, 14);
       dgSkill = SupernaturalEffect(dgSkill);
effect dhSkill = EffectSkillIncrease(SKILL_SEARCH, 16);
       dhSkill = SupernaturalEffect(dhSkill);
effect diSkill = EffectSkillIncrease(SKILL_SEARCH, 18);
       diSkill = SupernaturalEffect(diSkill);
effect djSkill = EffectSkillIncrease(SKILL_SEARCH, 20);
       djSkill = SupernaturalEffect(djSkill);
effect dkSkill = EffectSkillIncrease(SKILL_SEARCH, 20);
       dkSkill = SupernaturalEffect(dkSkill);

//// SKILL INCREASE - SPOT ////

effect eaSkill = EffectSkillIncrease(SKILL_SPOT, 2);
       eaSkill = SupernaturalEffect(eaSkill);
effect ebSkill = EffectSkillIncrease(SKILL_SPOT, 4);
       ebSkill = SupernaturalEffect(ebSkill);
effect ecSkill = EffectSkillIncrease(SKILL_SPOT, 6);
       ecSkill = SupernaturalEffect(ecSkill);
effect edSkill = EffectSkillIncrease(SKILL_SPOT, 8);
       edSkill = SupernaturalEffect(edSkill);
effect eeSkill = EffectSkillIncrease(SKILL_SPOT, 10);
       eeSkill = SupernaturalEffect(eeSkill);
effect efSkill = EffectSkillIncrease(SKILL_SPOT, 12);
       efSkill = SupernaturalEffect(efSkill);
effect egSkill = EffectSkillIncrease(SKILL_SPOT, 14);
       egSkill = SupernaturalEffect(egSkill);
effect ehSkill = EffectSkillIncrease(SKILL_SPOT, 16);
       ehSkill = SupernaturalEffect(ehSkill);
effect eiSkill = EffectSkillIncrease(SKILL_SPOT, 18);
       eiSkill = SupernaturalEffect(eiSkill);
effect ejSkill = EffectSkillIncrease(SKILL_SPOT, 20);
       ejSkill = SupernaturalEffect(ejSkill);
effect ekSkill = EffectSkillIncrease(SKILL_SPOT, 20);
       ekSkill = SupernaturalEffect(ekSkill);

//// SKILL INCREASE - TUMBLE ////

effect faSkill = EffectSkillIncrease(SKILL_TUMBLE, 2);
       faSkill = SupernaturalEffect(faSkill);
effect fbSkill = EffectSkillIncrease(SKILL_TUMBLE, 4);
       fbSkill = SupernaturalEffect(fbSkill);
effect fcSkill = EffectSkillIncrease(SKILL_TUMBLE, 6);
       fcSkill = SupernaturalEffect(fcSkill);
effect fdSkill = EffectSkillIncrease(SKILL_TUMBLE, 8);
       fdSkill = SupernaturalEffect(fdSkill);
effect feSkill = EffectSkillIncrease(SKILL_TUMBLE, 10);
       feSkill = SupernaturalEffect(feSkill);
effect ffSkill = EffectSkillIncrease(SKILL_TUMBLE, 12);
       ffSkill = SupernaturalEffect(ffSkill);
effect fgSkill = EffectSkillIncrease(SKILL_TUMBLE, 14);
       fgSkill = SupernaturalEffect(fgSkill);
effect fhSkill = EffectSkillIncrease(SKILL_TUMBLE, 16);
       fhSkill = SupernaturalEffect(fhSkill);
effect fiSkill = EffectSkillIncrease(SKILL_TUMBLE, 18);
       fiSkill = SupernaturalEffect(fiSkill);
effect fjSkill = EffectSkillIncrease(SKILL_TUMBLE, 20);
       fjSkill = SupernaturalEffect(fjSkill);
effect fkSkill = EffectSkillIncrease(SKILL_TUMBLE, 20);
       fkSkill = SupernaturalEffect(fkSkill);

//// SKILL INCREASE - CONCENTRATION ////

effect gaSkill = EffectSkillIncrease(SKILL_CONCENTRATION, 0);
       gaSkill = SupernaturalEffect(gaSkill);
effect gbSkill = EffectSkillIncrease(SKILL_CONCENTRATION, 0);
       gbSkill = SupernaturalEffect(gbSkill);
effect gcSkill = EffectSkillIncrease(SKILL_CONCENTRATION, 0);
       gcSkill = SupernaturalEffect(gcSkill);
effect gdSkill = EffectSkillIncrease(SKILL_CONCENTRATION, 0);
       gdSkill = SupernaturalEffect(gdSkill);
effect geSkill = EffectSkillIncrease(SKILL_CONCENTRATION, 0);
       geSkill = SupernaturalEffect(geSkill);
effect gfSkill = EffectSkillIncrease(SKILL_CONCENTRATION, 0);
       gfSkill = SupernaturalEffect(gfSkill);
effect ggSkill = EffectSkillIncrease(SKILL_CONCENTRATION, 0);
       ggSkill = SupernaturalEffect(ggSkill);
effect ghSkill = EffectSkillIncrease(SKILL_CONCENTRATION, 0);
       ghSkill = SupernaturalEffect(ghSkill);
effect giSkill = EffectSkillIncrease(SKILL_CONCENTRATION, 0);
       giSkill = SupernaturalEffect(giSkill);
effect gjSkill = EffectSkillIncrease(SKILL_CONCENTRATION, 0);
       gjSkill = SupernaturalEffect(gjSkill);
effect gkSkill = EffectSkillIncrease(SKILL_CONCENTRATION, 0);
       gkSkill = SupernaturalEffect(gkSkill);

//// SKILL INCREASE - DISCIPLINE ////

effect haSkill = EffectSkillIncrease(SKILL_DISCIPLINE, 2);
       haSkill = SupernaturalEffect(haSkill);
effect hbSkill = EffectSkillIncrease(SKILL_DISCIPLINE, 4);
       hbSkill = SupernaturalEffect(hbSkill);
effect hcSkill = EffectSkillIncrease(SKILL_DISCIPLINE, 6);
       hcSkill = SupernaturalEffect(hcSkill);
effect hdSkill = EffectSkillIncrease(SKILL_DISCIPLINE, 8);
       hdSkill = SupernaturalEffect(hdSkill);
effect heSkill = EffectSkillIncrease(SKILL_DISCIPLINE, 10);
       heSkill = SupernaturalEffect(heSkill);
effect hfSkill = EffectSkillIncrease(SKILL_DISCIPLINE, 12);
       hfSkill = SupernaturalEffect(hfSkill);
effect hgSkill = EffectSkillIncrease(SKILL_DISCIPLINE, 14);
       hgSkill = SupernaturalEffect(hgSkill);
effect hhSkill = EffectSkillIncrease(SKILL_DISCIPLINE, 16);
       hhSkill = SupernaturalEffect(hhSkill);
effect hiSkill = EffectSkillIncrease(SKILL_DISCIPLINE, 18);
       hiSkill = SupernaturalEffect(hiSkill);
effect hjSkill = EffectSkillIncrease(SKILL_DISCIPLINE, 20);
       hjSkill = SupernaturalEffect(hjSkill);
effect hkSkill = EffectSkillIncrease(SKILL_DISCIPLINE, 20);
       hkSkill = SupernaturalEffect(hkSkill);

//// TEMPORARY HITPOINTS ////

effect aHealth = EffectTemporaryHitpoints(10);
       aHealth = SupernaturalEffect(aHealth);
effect bHealth = EffectTemporaryHitpoints(15);
       bHealth = SupernaturalEffect(bHealth);
effect cHealth = EffectTemporaryHitpoints(20);
       cHealth = SupernaturalEffect(cHealth);
effect dHealth = EffectTemporaryHitpoints(25);
       dHealth = SupernaturalEffect(dHealth);
effect eHealth = EffectTemporaryHitpoints(30);
       eHealth = SupernaturalEffect(eHealth);
effect fHealth = EffectTemporaryHitpoints(35);
       fHealth = SupernaturalEffect(fHealth);
effect gHealth = EffectTemporaryHitpoints(40);
       gHealth = SupernaturalEffect(gHealth);
effect hHealth = EffectTemporaryHitpoints(45);
       hHealth = SupernaturalEffect(hHealth);
effect iHealth = EffectTemporaryHitpoints(50);
       iHealth = SupernaturalEffect(iHealth);

////////////////////////////////////
////// Bone Gnawer CHANGES /////////////
///////////////////////////////////

if (GetItemPossessedBy(oPC,"change_gnaw")!= OBJECT_INVALID)
{
DelayCommand(3.0, SetCreatureAppearanceType(oPC, 3205));

int oLevel = GetCharacterLevel(oPC);
if (oLevel >=1 && oLevel <=4)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, lDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, baAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, caAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, daAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aReduce, oPC);
}
if (oLevel >=5 && oLevel <=9)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, mDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, baAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cbAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dbAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aReduce, oPC);
}
if (oLevel >=10 && oLevel <=14)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, nDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dcAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ccAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bcAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bReduce, oPC);
}
if (oLevel >=15 && oLevel <=19)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, oDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ddAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bReduce, oPC);
}
if (oLevel >=20 && oLevel <=24)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, pDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cReduce, oPC);
}
if (oLevel >=25 && oLevel <=29)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, qDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, lRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ciAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cReduce, oPC);
}
if (oLevel >=30 && oLevel <=34)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, qDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, mRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dhAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cjAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
if (oLevel >=35 && oLevel <=39)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, rDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, nRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, diAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ciAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
if (oLevel >=40)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, sDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, jAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, oRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, djAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cjAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, jMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
}

////////////////////////////////////
////// Red Talons CHANGES //////////
///////////////////////////////////

if (GetItemPossessedBy(oPC,"change_red")!= OBJECT_INVALID)
{
DelayCommand(3.0, SetCreatureAppearanceType(oPC, 3204));

int oLevel = GetCharacterLevel(oPC);
if (oLevel >=1 && oLevel <=4)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, lDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, baAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, caAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, daAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aReduce, oPC);
}
if (oLevel >=5 && oLevel <=9)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, mDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, baAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cbAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dbAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aReduce, oPC);
}
if (oLevel >=10 && oLevel <=14)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, nDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dcAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ccAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bcAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bReduce, oPC);
}
if (oLevel >=15 && oLevel <=19)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, oDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ddAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bReduce, oPC);
}
if (oLevel >=20 && oLevel <=24)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, pDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cReduce, oPC);
}
if (oLevel >=25 && oLevel <=29)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, qDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, lRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ciAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cReduce, oPC);
}
if (oLevel >=30 && oLevel <=34)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, qDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, mRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dhAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cjAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
if (oLevel >=35 && oLevel <=39)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, rDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, nRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, diAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ciAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
if (oLevel >=40)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, sDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, jAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, oRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, djAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cjAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, jMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
}
////////////////////////////////////
////// Shadow Lord CHANGES /////////
///////////////////////////////////

if (GetItemPossessedBy(oPC,"change_shad")!= OBJECT_INVALID)
{
DelayCommand(3.0, SetCreatureAppearanceType(oPC, 1531));

int oLevel = GetCharacterLevel(oPC);
if (oLevel >=1 && oLevel <=4)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, lDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, baAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, caAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, daAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aReduce, oPC);
}
if (oLevel >=5 && oLevel <=9)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, mDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, baAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cbAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dbAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aReduce, oPC);
}
if (oLevel >=10 && oLevel <=14)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, nDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dcAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ccAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bcAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bReduce, oPC);
}
if (oLevel >=15 && oLevel <=19)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, oDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ddAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bReduce, oPC);
}
if (oLevel >=20 && oLevel <=24)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, pDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cReduce, oPC);
}
if (oLevel >=25 && oLevel <=29)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, qDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, lRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ciAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cReduce, oPC);
}
if (oLevel >=30 && oLevel <=34)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, qDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, mRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dhAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cjAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
if (oLevel >=35 && oLevel <=39)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, rDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, nRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, diAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ciAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
if (oLevel >=40)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, sDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, jAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, oRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, djAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cjAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, jMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
}
////////////////////////////////////
////// Black Spiral CHANGES /////////
///////////////////////////////////

if (GetItemPossessedBy(oPC,"change_spiral")!= OBJECT_INVALID)
{
DelayCommand(3.0, SetCreatureAppearanceType(oPC, 3206));

int oLevel = GetCharacterLevel(oPC);
if (oLevel >=1 && oLevel <=4)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, lDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, baAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, caAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, daAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aReduce, oPC);
}
if (oLevel >=5 && oLevel <=9)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, mDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, baAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cbAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dbAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aReduce, oPC);
}
if (oLevel >=10 && oLevel <=14)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, nDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dcAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ccAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bcAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bReduce, oPC);
}
if (oLevel >=15 && oLevel <=19)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, oDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ddAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bReduce, oPC);
}
if (oLevel >=20 && oLevel <=24)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, pDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cReduce, oPC);
}
if (oLevel >=25 && oLevel <=29)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, qDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, lRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ciAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cReduce, oPC);
}
if (oLevel >=30 && oLevel <=34)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, qDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, mRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dhAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cjAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
if (oLevel >=35 && oLevel <=39)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, rDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, nRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, diAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ciAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
if (oLevel >=40)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, sDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, jAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, oRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, djAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cjAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, jMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
}
////////////////////////////////////
////// Warders of Man CHANGES //////
///////////////////////////////////

if (GetItemPossessedBy(oPC,"change_ward")!= OBJECT_INVALID)
{
DelayCommand(3.0, SetCreatureAppearanceType(oPC, 3205));

int oLevel = GetCharacterLevel(oPC);
if (oLevel >=1 && oLevel <=4)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, lDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, baAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, caAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, daAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aReduce, oPC);
}
if (oLevel >=5 && oLevel <=9)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, mDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, baAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cbAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dbAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aReduce, oPC);
}
if (oLevel >=10 && oLevel <=14)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, nDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dcAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ccAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bcAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bReduce, oPC);
}
if (oLevel >=15 && oLevel <=19)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, oDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ddAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bReduce, oPC);
}
if (oLevel >=20 && oLevel <=24)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, pDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cReduce, oPC);
}
if (oLevel >=25 && oLevel <=29)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, qDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, lRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ciAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cReduce, oPC);
}
if (oLevel >=30 && oLevel <=34)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, qDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, mRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dhAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cjAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
if (oLevel >=35 && oLevel <=39)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, rDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, nRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, diAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ciAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
if (oLevel >=40)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, sDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, jAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, oRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, djAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cjAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, jMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
}

////////////////////////////////////
////// Silent Striders CHANGES //////
///////////////////////////////////

if (GetItemPossessedBy(oPC,"change_silent")!= OBJECT_INVALID)
{
DelayCommand(3.0, SetCreatureAppearanceType(oPC, 1552));

int oLevel = GetCharacterLevel(oPC);
if (oLevel >=1 && oLevel <=4)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, lDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, baAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, caAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, daAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aReduce, oPC);
}
if (oLevel >=5 && oLevel <=9)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, mDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, baAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cbAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dbAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, aReduce, oPC);
}
if (oLevel >=10 && oLevel <=14)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, nDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dcAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ccAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bcAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bReduce, oPC);
}
if (oLevel >=15 && oLevel <=19)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, oDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ddAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bReduce, oPC);
}
if (oLevel >=20 && oLevel <=24)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, pDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cReduce, oPC);
}
if (oLevel >=25 && oLevel <=29)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, qDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, fAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, lRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dgAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ciAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, bdAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cReduce, oPC);
}
if (oLevel >=30 && oLevel <=34)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, qDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, gAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, mRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dhAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cjAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
if (oLevel >=35 && oLevel <=39)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, rDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, hAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, nRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, diAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, ciAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
if (oLevel >=40)
{
ApplyEffectToObject(DURATION_TYPE_PERMANENT, sDamage, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, iAC, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, jAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, oRegen, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, djAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, cjAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, beAbility, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, jMove, oPC);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, dReduce, oPC);
}
}
}
