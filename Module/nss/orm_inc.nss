////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_inc
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from ORM Convo
//
////////////////////////////////////////////////////////////////////////////////

#include "x2_inc_toollib"
#include "x0_i0_position"
#include "nw_i0_spells"


//Smoking by Jason Robinson (For ORS by Olander)
void SmokePipe(object oPC);
location GetLocationAboveAndInFrontOf(object oPC, float fDist, float fHeight);

void GoAFK(object oPC)
{
  //Visual Effect ID
  int LOKAFK = 751;

  //Check AFK Status
  int nAFKStatus = GetLocalInt(oPC,"IsAFK");

  //Not in AFK so Apply Effect and Set AFK
  if(nAFKStatus == 0)
  {
    //Set AFK Status
    SetLocalInt(oPC,"IsAFK",1);

    effect eLOKAFK = EffectVisualEffect(LOKAFK);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eLOKAFK,oPC);
    FloatingTextStringOnCreature("I am currently Away From My Keyboard...",oPC);
  }
}

void RemoveAFK(object oPC)
{
  //Set AFK Status
  SetLocalInt(oPC,"IsAFK",0);

  //Remove the Visual Effect
  effect eEffect = GetFirstEffect(oPC);
  while(GetIsEffectValid(eEffect))
  {
    if(GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT) RemoveEffect(oPC, eEffect);
    eEffect = GetNextEffect(oPC);
  }

  FloatingTextStringOnCreature("I am back from AFK!",oPC);
}

//Dance by Madrabbit
void Dance(object oPC)
{
  object oRH = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
  object oLH =  GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);

  if(GetIsObjectValid(oRH)) AssignCommand(oPC,ActionUnequipItem(oRH));
  if(GetIsObjectValid(oLH)) AssignCommand(oPC,ActionUnequipItem(oLH));

  AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY2,1.0));
  AssignCommand(oPC,ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH,oPC)));
  AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_TALK_LAUGHING, 2.0, 2.0));
  AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY1,1.0));
  AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY3,2.0));
  AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_GET_MID, 3.0, 1.0));
  AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_TALK_FORCEFUL,1.0));
  AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY2,1.0));
  AssignCommand(oPC,ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH,oPC)));
  AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_TALK_LAUGHING, 2.0, 2.0));
  AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY1,1.0));
  AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY3,2.0));
  AssignCommand(oPC,ActionDoCommand(PlayVoiceChat(VOICE_CHAT_LAUGH,oPC)));
  AssignCommand(oPC,ActionPlayAnimation( ANIMATION_LOOPING_GET_MID, 3.0, 1.0));
  AssignCommand(oPC,ActionPlayAnimation( ANIMATION_FIREFORGET_VICTORY2,1.0));

  if(GetIsObjectValid(oRH)) AssignCommand(oPC,ActionDoCommand(ActionEquipItem(oRH,INVENTORY_SLOT_RIGHTHAND)));
  if(GetIsObjectValid(oLH)) AssignCommand(oPC,ActionDoCommand(ActionEquipItem(oLH,INVENTORY_SLOT_LEFTHAND)));
}

void EmoteSpeedSub(object oPC,float fSub)
{
  float fSpeed = GetLocalFloat(oPC,"ORM_SPEED");
  if(fSpeed > 0.1) SetLocalFloat(oPC,"ORM_SPEED",fSpeed - fSub);
  SetCustomToken(6664,FloatToString(fSpeed - fSub));
}

void EmoteSpeedAdd(object oPC,float fAdd)
{
  float fSpeed = GetLocalFloat(oPC,"ORM_SPEED");
  if(fSpeed < 2.0) SetLocalFloat(oPC,"ORM_SPEED",fSpeed + fAdd);
  SetCustomToken(6664,FloatToString(fSpeed + fAdd));
}

void PlayUnivEmote(object oPC,int nEmote)
{
  float fSpeed = GetLocalFloat(oPC,"ORM_SPEED");
  AssignCommand(oPC,ClearAllActions());

  switch(nEmote)
  {
    case 0:   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE,fSpeed,3600.00)); break;
    case 1:   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE2,fSpeed,3600.00)); break;
    case 2:   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_LISTEN,fSpeed,3600.00)); break;
    case 3:   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE,fSpeed,3600.00)); break;
    case 4:   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP,fSpeed,3600.00)); break;
    case 5:   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR,fSpeed,3600.00)); break;
    case 6:   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_SIT_CHAIR,fSpeed,3600.00)); break;
    case 7:   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS,fSpeed,3600.00)); break;
    case 8:   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL,fSpeed,3600.00)); break;
    case 9:   AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING,fSpeed,3600.00)); break;
    case 10:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,fSpeed,3600.00)); break;
    case 11:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING,fSpeed,3600.00)); break;
    case 12:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,fSpeed,3600.00)); break;
    case 13:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,fSpeed,3600.00)); break;
    case 14:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED,fSpeed,3600.00)); break;
    case 15:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,fSpeed,3600.00)); break;
    case 16:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,fSpeed,3600.00)); break;
    case 17:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK,fSpeed,3600.00)); break;
    case 18:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,fSpeed,3600.00)); break;
    case 19:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CONJURE2,fSpeed,3600.00)); break;
    case 20:  AssignCommand(oPC,Dance(oPC)); break;
    case 21:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM1,fSpeed,3600.00)); break;
    case 22:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM2,fSpeed,3600.00)); break;
    case 23:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM3,fSpeed,3600.00)); break;
    case 24:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM4,fSpeed,30.0)); break;
    case 25:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM5,fSpeed,3600.00)); break;
    case 26:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM6,2.0,2.0)); break;
    case 27:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM7,fSpeed,3600.00)); break;
    case 28:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM8,fSpeed,3600.00)); break;
    case 29:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM9,fSpeed,3600.00)); break;
    case 30:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_CUSTOM10,fSpeed,3600.00)); break;
    case 31:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT)); break;
    case 32:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT)); break;
    case 33:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD)); break;
    case 34:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED,fSpeed)); break;
    case 35:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE)); break;
    case 36:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_BOW)); break;
    case 37:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL)); break;
    case 38:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING)); break;
    case 39:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT)); break;
    case 40:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_READ)); break;
    case 41:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK)); break;
    case 42:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_SIDE)); break;
    case 43:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DODGE_DUCK)); break;
    case 44:  AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_SPASM)); break;
    case 45:
      switch(d3())
      {
        case 1:AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1));break;
        case 2:AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2));break;
        case 3:AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY3));break;
      }
      break;
    case 46:  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 4.0)); break;
    case 47:  SmokePipe(oPC); break;
    case 48:  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 4.0)); break;
  }
}

void SmokePipe(object oPC)
{
  string sEmote1 = "*puffs on a pipe*";
  string sEmote2 = "*inhales from a pipe*";
  string sEmote3 = "*pulls a mouthful of smoke from a pipe*";
  float fHeight = 1.7;
  float fDistance = 0.1;

  if (GetGender(oPC) == GENDER_MALE)
  {
    switch (GetRacialType(oPC))
    {
      case RACIAL_TYPE_HUMAN:
      case RACIAL_TYPE_HALFELF: fHeight = 1.7; fDistance = 0.12; break;
      case RACIAL_TYPE_ELF: fHeight = 1.55; fDistance = 0.08; break;
      case RACIAL_TYPE_GNOME:
      case RACIAL_TYPE_HALFLING: fHeight = 1.15; fDistance = 0.12; break;
      case RACIAL_TYPE_DWARF: fHeight = 1.2; fDistance = 0.12; break;
      case RACIAL_TYPE_HALFORC: fHeight = 1.9; fDistance = 0.2; break;
    }
  }
  else
  {
    switch (GetRacialType(oPC))
    {
      case RACIAL_TYPE_HUMAN:
      case RACIAL_TYPE_HALFELF: fHeight = 1.6; fDistance = 0.12; break;
      case RACIAL_TYPE_ELF: fHeight = 1.45; fDistance = 0.12; break;
      case RACIAL_TYPE_GNOME:
      case RACIAL_TYPE_HALFLING: fHeight = 1.1; fDistance = 0.075; break;
      case RACIAL_TYPE_DWARF: fHeight = 1.2; fDistance = 0.1; break;
      case RACIAL_TYPE_HALFORC: fHeight = 1.8; fDistance = 0.13; break;
    }
  }

  location lAboveHead = GetLocationAboveAndInFrontOf(oPC, fDistance, fHeight);
  switch (d3())
  {
    case 1: AssignCommand(oPC, ActionSpeakString(sEmote1)); break;
    case 2: AssignCommand(oPC, ActionSpeakString(sEmote2)); break;
    case 3: AssignCommand(oPC, ActionSpeakString(sEmote3));break;
  }
  AssignCommand(oPC, ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_LIGHT_RED_5), oPC, 0.15)));
  AssignCommand(oPC, ActionWait(3.0));
  AssignCommand(oPC, ActionDoCommand(ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), lAboveHead)));
  if((GetGender(oPC) == GENDER_FEMALE) && (GetRacialType(oPC) != RACIAL_TYPE_DWARF))
  {
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 1.0, 5.0));
  }
}

location GetLocationAboveAndInFrontOf(object oPC, float fDist, float fHeight)
{
  float fDistance = -fDist;
  object oTarget = (oPC);
  object oArea = GetArea(oTarget);
  vector vPosition = GetPosition(oTarget);
  vPosition.z += fHeight;
  float fOrientation = GetFacing(oTarget);
  vector vNewPos = AngleToVector(fOrientation);
  float vZ = vPosition.z;
  float vX = vPosition.x - fDistance * vNewPos.x;
  float vY = vPosition.y - fDistance * vNewPos.y;
  fOrientation = GetFacing(oTarget);
  vX = vPosition.x - fDistance * vNewPos.x;
  vY = vPosition.y - fDistance * vNewPos.y;
  vNewPos = AngleToVector(fOrientation);
  vZ = vPosition.z;
  vNewPos = Vector(vX, vY, vZ);
  return Location(oArea, vNewPos, fOrientation);
}

void DestroyLap(object oLapTarget)
{
  if (!GetIsObjectValid(GetSittingCreature(oLapTarget)))
  {
    DestroyObject(oLapTarget);
  }
  else
  {
    DelayCommand(10.0, DestroyLap(oLapTarget));
  }
}

void LapSit(object oPC,string sDir)
{
  object oCreature = OBJECT_SELF;
  location lCreature; location lSitTarget; location lLapTarget;
  object oPlaceable; object oSitter; object oSitTarget;
  object oSitTargetArea; object oLapTarget; object oLapCheck;
  float fSitTargetFacing; float fDistance;
  vector vSitTarget; vector vLapTarget;

  int iCount = 0;
  while(oCreature != OBJECT_INVALID)
  {
    iCount = iCount + 1;
    oCreature = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC, iCount);

    if( oCreature != OBJECT_INVALID)
    {
      lCreature = GetLocation(oCreature);
      oPlaceable = GetNearestObjectToLocation( OBJECT_TYPE_PLACEABLE, lCreature);
      if(oPlaceable != OBJECT_INVALID)
      {
        oSitter = GetSittingCreature( oPlaceable);
        if(oSitter != OBJECT_INVALID)
        {
          if(oSitter == oCreature)
          {
            if(GetDistanceToObject( oSitter) > 0.0 && GetDistanceToObject( oSitter) < 2.5)
            {
              oSitTarget = oCreature;
              lSitTarget = lCreature;
            }
          }
        }
      }
    }
  }

  //SitTarget
  fSitTargetFacing = GetFacing( oSitTarget);
  oSitTargetArea = GetArea( oSitTarget);
  vSitTarget = GetPositionFromLocation( lSitTarget);

  //LapTarget
  if(sDir == "Away")
  {
    fDistance = 0.25;
    vLapTarget = GetChangedPosition( vSitTarget, fDistance, fSitTargetFacing);
    fSitTargetFacing = GetOppositeDirection( fSitTargetFacing);
    lLapTarget = Location( oSitTargetArea, vLapTarget, fSitTargetFacing);
  }
  if(sDir == "Left")
  {
    fDistance = 0.2;
    vLapTarget = GetChangedPosition( vSitTarget, fDistance, fSitTargetFacing);
    fSitTargetFacing = GetNormalizedDirection( fSitTargetFacing - 90.0);
    lLapTarget = Location( oSitTargetArea, vLapTarget, fSitTargetFacing);
  }
  if(sDir == "Right")
  {
    fDistance = 0.2;
    vLapTarget = GetChangedPosition( vSitTarget, fDistance, fSitTargetFacing);
    fSitTargetFacing = GetNormalizedDirection( fSitTargetFacing + 90.0);
    lLapTarget = Location( oSitTargetArea, vLapTarget, fSitTargetFacing);
  }
  if(sDir == "To")
  {
    fDistance = 0.2;
    vLapTarget = GetChangedPosition( vSitTarget, fDistance, fSitTargetFacing);
    lLapTarget = Location( oSitTargetArea, vLapTarget, fSitTargetFacing);
  }

  //Sitting Object at lLapTarget and Sit
  oLapTarget = CreateObject( OBJECT_TYPE_PLACEABLE, "plc_invisobj", lLapTarget);
  AssignCommand( oPC, ActionSit(oLapTarget));

  //Loop on PC Every 10 seconds to Check for Sitting
  DelayCommand(10.0, DestroyLap(oLapTarget));
}

void MoveAndFaceBehindOpposite(object oPC, float fDist)
{
  object oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC) ;
  float fTargetface = GetOppositeDirection (GetFacing(oTarget));
  float fPCFace = GetOppositeDirection(GetFacing(oTarget));

  object oArea = GetArea(oPC);
  vector posDest = GetPosition(oTarget) + AngleToVector(fTargetface)* fDist;
  location lDest = Location(oArea, posDest, fPCFace);
  MoveToNewLocation(lDest,oPC);
}

void MoveAndFaceBehindSame(object oPC, float fDist)
{
  object oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC) ;
  float fTargetface = GetOppositeDirection (GetFacing(oTarget));
  float fPCFace = GetFacing(oTarget);

  object oArea = GetArea(oPC);
  vector posDest = GetPosition(oTarget) + AngleToVector(fTargetface)* fDist;
  location lDest = Location(oArea, posDest, fPCFace);
  MoveToNewLocation(lDest,oPC);
}

void MoveAndFaceBehindOffset(object oPC, float fDist)
{
  object oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC) ;
  float fTargetface = GetOppositeDirection (GetFacing(oTarget));
  float fPCFace = GetFacing(oTarget);

  fTargetface = GetNormalizedDirection(fTargetface - 25.0);

  object oArea = GetArea(oPC);
  vector posDest = GetPosition(oTarget) + AngleToVector(fTargetface)* fDist;
  location lDest = Location(oArea, posDest, fPCFace);
  MoveToNewLocation(lDest,oPC);
}

void MoveAndFaceSameSame(object oPC, float fDist)
{
  object oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC) ;
  float fTargetface = GetFacing(oTarget);
  float fPCFace = fTargetface;

  object oArea = GetArea(oPC);
  vector posDest = GetPosition(oTarget) + AngleToVector(fTargetface)* fDist;
  location lDest = Location(oArea, posDest, fPCFace);
  MoveToNewLocation(lDest,oPC);
}

void MoveAndFaceTowards(object oPC, float fDist)
{
  object oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC) ;
  float fTargetface = GetFacing(oTarget);
  float fPCFace = GetOppositeDirection(fTargetface);

  object oArea = GetArea(oPC);
  vector posDest = GetPosition(oTarget) + AngleToVector(fTargetface)* fDist;
  location lDest = Location(oArea, posDest, fPCFace);
  MoveToNewLocation(lDest,oPC);
}

void MoveAndFaceFaceKiss(object oPC, float fDist)
{
  object oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC) ;
  float fTargetface = GetFacing(oTarget);
  float fPCFace = GetOppositeDirection(fTargetface);

  fTargetface = GetNormalizedDirection(fTargetface + 5.0);

  object oArea = GetArea(oPC);
  vector posDest = GetPosition(oTarget) + AngleToVector(fTargetface)* fDist;
  location lDest = Location(oArea, posDest, fPCFace);
  MoveToNewLocation(lDest,oPC);
}

void MoveAndFaceFaceHug(object oPC, float fDist)
{
  object oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC) ;
  float fTargetface = GetFacing(oTarget);
  float fPCFace = GetOppositeDirection(fTargetface);

  fTargetface = GetNormalizedDirection(fTargetface - 50.0);

  object oArea = GetArea(oPC);
  vector posDest = GetPosition(oTarget) + AngleToVector(fTargetface)* fDist;
  location lDest = Location(oArea, posDest, fPCFace);
  MoveToNewLocation(lDest,oPC);
}

void MoveAndFaceFaceLaps(object oPC, float fDist)
{
  object oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC) ;
  float fTargetface = GetFacing(oTarget);
  float fPCFace = GetOppositeDirection(fTargetface);

  fTargetface = GetNormalizedDirection(fTargetface + 20.0);
  fPCFace = GetNormalizedDirection(fPCFace - 10.0);

  object oArea = GetArea(oPC);
  vector posDest = GetPosition(oTarget) + AngleToVector(fTargetface)* fDist;
  location lDest = Location(oArea, posDest, fPCFace);
  MoveToNewLocation(lDest,oPC);
}

void MoveAndOverMouthStraddle(object oPC, float fDist)
{
  object oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC) ;
  float fTargetface = GetFacing(oTarget);
  float fPCFace = fTargetface;

  fTargetface = GetNormalizedDirection(fTargetface - 6.0);
  fPCFace = GetNormalizedDirection(fPCFace - 20.0);

  object oArea = GetArea(oPC);
  vector posDest = GetPosition(oTarget) + AngleToVector(fTargetface)* fDist;
  location lDest = Location(oArea, posDest, fPCFace);
  MoveToNewLocation(lDest,oPC);
}

void MoveAndOverMouthCross(object oPC, float fDist)
{
  object oTarget = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC) ;
  float fTargetface = GetFacing(oTarget);
  float fPCFace = fTargetface;

  fTargetface = GetNormalizedDirection(fTargetface - 2.5);
  fPCFace = GetNormalizedDirection(fPCFace - 70.0);

  object oArea = GetArea(oPC);
  vector posDest = GetPosition(oTarget) + AngleToVector(fTargetface)* fDist;
  location lDest = Location(oArea, posDest, fPCFace);
  MoveToNewLocation(lDest,oPC);
}

void Scrying(object oPC,object oTarg)
{
  location pcLocation=GetLocation(oPC);
  float scrydur=16.0+IntToFloat(GetCasterLevel(oPC)/3);

  if(GetCasterLevel(oPC)<=GetCasterLevel(oTarg))
  {
    if(d4()>2) SendMessageToPC(oTarg,"You sense you are being watched from afar.");
  }

  object oCopy=CopyObject(oPC,pcLocation,OBJECT_INVALID,GetName(oPC)+"copy");
  DestroyObject(oCopy,scrydur-0.2);
  RemoveSpellEffects(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE,oPC,oPC);

  DelayCommand(scrydur+0.4,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetMaxHitPoints(oCopy),DAMAGE_TYPE_POSITIVE,DAMAGE_POWER_NORMAL),oCopy));

  AssignCommand(oCopy,ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,0.2,3600.00));
  ChangeToStandardFaction(oCopy,STANDARD_FACTION_MERCHANT);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_PROT_PREMONITION ),oCopy,scrydur-0.6);
  SetImmortal(oCopy,TRUE);
  SetCutsceneMode(oPC,TRUE);
  DelayCommand(scrydur+0.5,SetCutsceneMode(oPC,FALSE));
  DelayCommand(scrydur+0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(GetMaxHitPoints(oCopy)-GetCurrentHitPoints(oCopy),DAMAGE_TYPE_POSITIVE,DAMAGE_POWER_NORMAL),oPC));
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectEthereal(),oPC,scrydur+0.5);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY),oPC,scrydur+0.5);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneGhost(),oPC,scrydur+0.5);
  AssignCommand(oPC,ActionJumpToObject(oTarg,FALSE));

  DelayCommand(scrydur-0.3,AssignCommand(oPC,ClearAllActions()));
  DelayCommand(scrydur-0.7,SetPlotFlag(oPC,FALSE));
  pcLocation=GetLocation(oCopy);
  DelayCommand(scrydur,AssignCommand(oPC,ActionJumpToLocation(pcLocation)));

  AssignCommand(oPC,ActionForceFollowObject(oTarg,1.0));
  SetPlotFlag(oPC,TRUE);
}


//void main(){}
