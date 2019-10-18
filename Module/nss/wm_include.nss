// HCR v3.2.0 - Re-Added spell tracking code.
//::////////////////////////////////////////////////////////////////////////////
//:: FileName:  WM_Include
//::////////////////////////////////////////////////////////////////////////////
/*
   WILD MAGIC SYSTEM by Lex. Adapted to HCR system by Archaegeo. Modified by
  Jamos to add spell failure based on abilities and scrolls.
*/
//::////////////////////////////////////////////////////////////////////////////
#include "hc_inc_ability"
#include "hc_inc_pwdb_func"
#include "hc_inc_timecheck"
#include "hc_inc_component"
#include "hc_inc"
//::////////////////////////////////////////////////////////////////////////////


// Set MATERCOMP to 0 to not use material components for those spells that need.
int MATERCOMP = 1;

// Indicates magical normality
int WM_NORMAL = 0;

// Indicates lack of magical energy
int WM_NULL = 1;

// Indicates erratic magical energy
int WM_WILD = 2;

// Checks to see whether the spell script should not continue normally.
// Use: if (WildMagicOverride()) { return; }
// The function should be able to figure out the three parameters on its own.
// If not, or if you are using it in a non-spell script, provide up to three
// objects involved in the check. Leave any unused parameters as OBJECT_INVALID
// to have them autodetect, or use the same object more than once.
// Should work in item activation scripts!
int WildMagicOverride(object oArea = OBJECT_INVALID,
                      object oCaster = OBJECT_INVALID,
                      object oTarget = OBJECT_INVALID);

// Similar to WildMagicOverride, but does not include Wild effects. Mostly used
// in situations where wild effects would be inappropriate, like in an AOE's
// heartbeat and OnEnter scripts.
int NullMagicOverride(object oArea = OBJECT_INVALID,
                      object oCaster = OBJECT_INVALID,
                      object oTarget = OBJECT_INVALID);

// Modifies the magic state of oTarget. nState is one of
// WM_NORMAL, WM_NULL, WM_WILD. Wild and Null magic stack, allowing
// you to safely add and remove these effects without interfering with
// other things that deal with these states. Modifying WM_NORMAL positively
// will decrease the wild and null effects that much, while modifying it
// negatively will remove all wild and null effects.
void SetWMState(object oTarget, int nState, int nAmount=1);

// Returns WM_NORMAL, WM_NULL, or WM_WILD.
// If the object is both wild and null, WM_NULL is returned.
int GetWMState(object oTarget);

// Creates a Wild Magic area of effect. Creatures in the AOE
// are considered Wild until they leave it.
// EXPERIMENTAL.
// Problems: Placeables don't seem to be affected by this,
// so spells can be cast into the AOE as long as they target
// either a placeable or a location.
effect EffectWildMagicAOE();

// Creates a Null Magic area of effect. Creatures in the AOE
// are considered null until they leave it.
// EXPERIMENTAL.
// Problems: Placeables don't seem to be affected by this,
// so spells can be cast into the AOE as long as they target
// either a placeable or a location.
effect EffectNullMagicAOE();

// Removes all magical effects on a target.
void RemoveMagicalEffects (object oTarget);

// Used by WildMagicOverride()
int GoWild(object oCaster, object oTarget, location lLocation);

// Used by GoWild()
void SpecialCast(int nSpell, object oTarget, location lLocation, int nCasterLevel, int nMetaMagic);

// A creature or placeable nearby oTarget is randomly
// chosen and returned. May return oTarget, especially
// if there are few objects nearby.
object GetRandomNearby(object oTarget=OBJECT_SELF);

// Used by GoWild()
void RandomCast();

// Fix for spells creating neg. hitpoints.
void ResPlayer(object oPC, int nHP)
{
      if (GPS(oPC) != PWS_PLAYER_STATE_ALIVE)
      {
         ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oPC);
         ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHP-1), oPC);
      }

}

void HC_HitPoints(object oPC, int nHP)
{
   //SendMessageToPC(oPC, "Original Hitpoints : " + IntToString(nHP));
   int nCHP = GetCurrentHitPoints(oPC);
   //SendMessageToPC(oPC, "Current Hitpoints : " + IntToString(nCHP));
   if (nCHP < -9)
   {
         DelayCommand(7.0, ResPlayer(oPC, nHP));
   }
   else
   {
      if (GetHasSpellEffect(387, oPC) ||
          GetHasSpellEffect(388, oPC) ||
          GetHasSpellEffect(389, oPC) ||
          GetHasSpellEffect(390, oPC) ||
          GetHasSpellEffect(391, oPC) ||
          GetHasSpellEffect(392, oPC) ||
          GetHasSpellEffect(393, oPC) ||
          GetHasSpellEffect(394, oPC) ||
          GetHasSpellEffect(395, oPC) ||
          GetHasSpellEffect(396, oPC) ||
          GetHasSpellEffect(401, oPC) ||
          GetHasSpellEffect(402, oPC) ||
          GetHasSpellEffect(403, oPC) ||
          GetHasSpellEffect(404, oPC) ||
          GetHasSpellEffect(405, oPC) ||
          GetHasSpellEffect(SPELL_TENSERS_TRANSFORMATION, oPC))
              DelayCommand(6.0, HC_HitPoints(oPC, nCHP));
   }
}

// Checks for the old WM_STATE variable and makes the necessary
// adjustments. Called by Get and SetWMState, probably no use
// for it elsewhere.
void DoWMUpdate(object oTarget)
{
    int nState = GetLocalInt(oTarget, "WM_STATE");
    DeleteLocalInt(oTarget, "WM_STATE");
    if (!nState) return;
    SetWMState(oTarget, nState);
}

void SetWMState(object oTarget, int nState, int nAmount=1)
{
    DoWMUpdate(oTarget);
    if (nState < 0 || nState > 2) nState = 0;
    if (nState == WM_NULL)
    {
        int x = GetLocalInt(oTarget, "MAGICSTATE_NULL") + nAmount;
        if (x < 0) x = 0;
        SetLocalInt(oTarget, "MAGICSTATE_NULL", x);
        int nType = GetObjectType(oTarget);
        // Dispel magical effects on the target
        if (x > 0) RemoveMagicalEffects(oTarget);
    }
    else if (nState == WM_WILD)
    {
        int x = GetLocalInt(oTarget, "MAGICSTATE_WILD") + nAmount;
        if (x < 0) x = 0;
        SetLocalInt(oTarget, "MAGICSTATE_WILD", x);
    }
    else if (nState = WM_NORMAL)
    {
        if (nAmount > 0) {
        SetWMState(oTarget, WM_NULL, -nAmount);
        SetWMState(oTarget, WM_WILD, -nAmount);
        }
        else
        {
            SetLocalInt(oTarget, "MAGICSTATE_NULL", 0);
            SetLocalInt(oTarget, "MAGICSTATE_WILD", 0);
        }
    }
}

int GetWMState(object oTarget)
{
    DoWMUpdate(oTarget);
    int nNull = GetLocalInt(oTarget, "MAGICSTATE_NULL");
    if (nNull > 0) return WM_NULL;
    int nWild = GetLocalInt(oTarget, "MAGICSTATE_WILD");
    if (nWild > 0) return WM_WILD;
    return WM_NORMAL;
}

int NullMagicOverride(object oArea = OBJECT_INVALID,
                      object oCaster = OBJECT_INVALID,
                      object oTarget = OBJECT_INVALID)
{
    int nModuleState = GetWMState(GetModule());
    object oItem = GetItemActivated();
    if (oItem == OBJECT_INVALID) oItem = GetSpellCastItem();
    int nItemState = GetWMState(oItem);
    location lTargetLocation;
    if (oCaster == OBJECT_INVALID)
    {
        oCaster = GetLastSpellCaster();
        lTargetLocation = GetSpellTargetLocation();
    }
    if (oCaster == OBJECT_INVALID) {
        oCaster = GetItemActivator();
        lTargetLocation = GetItemActivatedTargetLocation();
    }
    if (oCaster == OBJECT_INVALID)
    {
        oCaster = OBJECT_SELF;
        lTargetLocation = GetLocation(OBJECT_SELF);
    }
    if (oTarget == OBJECT_INVALID) oTarget = GetSpellTargetObject();
    if (oTarget == OBJECT_INVALID) oTarget = GetItemActivatedTarget();
    if (oTarget == OBJECT_INVALID) oTarget = oCaster;
    if (oArea == OBJECT_INVALID) oArea = GetArea(oCaster);
    if (oArea == OBJECT_INVALID) oArea = GetArea(oTarget);
    int nCasterState = GetWMState(oCaster);
    int nTargetState = GetWMState(oTarget);
    int nAreaState = GetWMState(oArea);

    if (nModuleState == 1 ||
        nItemState == 1 ||
        nCasterState == 1 ||
        nTargetState == 1 ||
        nAreaState == 1)
    {
        return 1;
    }
    if (oTarget == oCaster)
    {
        object oInvis = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTargetLocation);
        if (GetWMState(oInvis) == WM_NULL)
        {
            DestroyObject(oInvis);
            return 1;
        }
    DestroyObject(oInvis);
    }

    return 0;
}

int WildMagicOverride(object oArea = OBJECT_INVALID,
                      object oCaster = OBJECT_INVALID,
                      object oTarget = OBJECT_INVALID)
{
    object oW=GetLastSpellCaster();
    if(oW==OBJECT_INVALID) oW=OBJECT_SELF;

    //SendMessageToPC(OBJECT_SELF, "Spell ID: " + IntToString(GetSpellId()));
    // SPELL TRACKING BEGIN
    if(GetSpellCastItem()==OBJECT_INVALID)
    {
        // hcr3.1
        string sNm=GetName(oW);
        string sPC=GetPCPlayerName(oW);
        int nSp=GetSpellId();
        object oMd=GetModule();
        int nTm=GetLocalInt(oMd, "SPTRK"+sNm+sPC+IntToString(nSp));
        SetLocalInt(oMd,"SPTRK"+sNm+sPC+IntToString(nSp), (nTm+1));

        // hcr3.1 check for spells if not rested this would be only if decrement on enter is used.
        int iResult = GetLocalInt(GetModule(), GetName(oW)+GetPCPlayerName(oW)+"NOTRESTED");
        if (iResult && GetLocalInt(GetModule(), "DECONENTER"))
            return 1;
        //int nSp = GetSpellId();
        // hcr3.1 spell components.
        if (GetLocalInt(oMod, "MATERCOMP"))
        {
        iResult = CheckComponents(nSp);
        if (iResult)
            return 1;
        }
    }
    // END SPELL TRACKING
    object oCItem = GetSpellCastItem();
    // 5.5
    // hcr3.1 disabled remove.
    // Ability Score Check
    //if (oCItem == OBJECT_INVALID)
        //AbilityCheck(oW, GPS(oW));
        //AbilityCheck(oW, GetPersistentInt(GetModule(), "PlayerState" + GetName(oW) + GetPCPlayerName(oW)));
    if (oCItem != OBJECT_INVALID )
        if(GetBaseItemType(oCItem)== BASE_ITEM_SPELLSCROLL)
          if (ScrollCast()) return 1;
    int nModuleState = GetWMState(GetModule());
    object oItem = GetItemActivated();
    if (oItem == OBJECT_INVALID) oItem = GetSpellCastItem();
    int nItemState = GetWMState(oItem);
    location lTargetLocation = GetSpellTargetLocation();
    if (oCaster == OBJECT_INVALID)
    {
        oCaster = GetLastSpellCaster();
        lTargetLocation = GetSpellTargetLocation();
    }
    if (oCaster == OBJECT_INVALID) {
        oCaster = GetItemActivator();
        lTargetLocation = GetItemActivatedTargetLocation();
    }
    if (oCaster == OBJECT_INVALID)
    {
        oCaster = OBJECT_SELF;
        lTargetLocation = GetLocation(OBJECT_SELF);
    }
    if (oTarget == OBJECT_INVALID) oTarget = GetSpellTargetObject();
    if (oTarget == OBJECT_INVALID) oTarget = GetItemActivatedTarget();
    if (oTarget == OBJECT_INVALID) oTarget = oCaster;
    if (oArea == OBJECT_INVALID) oArea = GetArea(oCaster);
    if (oArea == OBJECT_INVALID) oArea = GetArea(oTarget);

    // Null magic code moved
    int bIsNull = NullMagicOverride(oArea, oCaster, oTarget);
    if (bIsNull) { return bIsNull; }

    int nCasterState = GetWMState(oCaster);
    int nTargetState = GetWMState(oTarget);
    int nAreaState = GetWMState(oArea);

    if (nModuleState == 2 ||
        nItemState == 2 ||
        nCasterState == 2 ||
        nTargetState == 2 ||
        nAreaState == 2)
    {
        return GoWild(oCaster, oTarget, lTargetLocation);
    }

    if (oTarget == oCaster) {
        object oInvis = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lTargetLocation);
        if (GetWMState(oInvis) == WM_WILD)
        {
            DestroyObject(oInvis);
            return GoWild(oCaster, oTarget, lTargetLocation);
        }
        DestroyObject(oInvis);
    }
    // hcr3.1
    DelayCommand(6.0, HC_HitPoints(OBJECT_SELF, 0));
    return 0;
}

int GoWild(object oCaster, object oTarget, location lLocation)
{
    int nCasterLevel = GetCasterLevel(oCaster);
    if (GetLocalInt(OBJECT_SELF, "WILDCASTING"))
    {
        DeleteLocalInt(OBJECT_SELF, "WILDCASTING");
        return 0;
    }

    int nSpell = GetSpellId();
    int nMetaMagic = GetMetaMagicFeat();

    int nRoll = d100();

    if (nRoll == 100) {
        object oNewTarget = GetRandomNearby(oTarget);
        float fDuration = IntToFloat(d20(2)*6);
        int nState = d2();
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                            EffectVisualEffect(VFX_IMP_HEAD_ODD),
                            oNewTarget, fDuration);
        SetWMState(oNewTarget, nState);
        DelayCommand(fDuration, SetWMState(oNewTarget, nState, -1));
        return 0;
    }
    else if (nRoll >= 96)
    {
        AssignCommand(oCaster, SpecialCast(nSpell, oTarget,
                                           lLocation, nCasterLevel,
                                           METAMAGIC_MAXIMIZE));
        return 1;
    }
    else if (nRoll >= 86)
    {
        AssignCommand(oCaster, SpecialCast(nSpell, oTarget,
                                           lLocation, nCasterLevel,
                                           METAMAGIC_EXTEND));
        return 1;
    }
    else if (nRoll >= 56)
    {
        return 0;
    }
    else if (nRoll >= 54)
    {
        CreateObject(OBJECT_TYPE_PLACEABLE, "plc_butterflies",
                     GetLocation(oCaster));
        return 1;
    }
    else if (nRoll >= 51)
    {
        AssignCommand(oCaster, SpecialCast(nSpell, oCaster,
                                           lLocation, nCasterLevel,
                                           nMetaMagic));
        return 0;
    }
    else if (nRoll >= 41)
    {
        object oNewCaster = GetRandomNearby(oTarget);
        object oNewTarget = GetRandomNearby(oCaster);
        lLocation = GetLocation(oNewTarget);
        AssignCommand(oNewCaster, SpecialCast(nSpell, oNewTarget,
                                              lLocation, nCasterLevel,
                                              nMetaMagic));
        return 1;
    }
    else if (nRoll >= 26)
    {
        return 1;
    }
    else if (nRoll >= 11)
    {
        object oNewTarget = GetRandomNearby(oCaster);
        lLocation = GetLocation(oNewTarget);
        AssignCommand(oCaster, SpecialCast(nSpell, oNewTarget,
                                           lLocation, nCasterLevel,
                                           nMetaMagic));
        return 1;
    }
    else
    {
        AssignCommand(oCaster, RandomCast());
        return 1;
    }
}

void SpecialCast(int nSpell, object oTarget, location lLocation, int nCasterLevel, int nMetaMagic)
{
    object oCaster = OBJECT_SELF;
    SetLocalInt(oCaster, "WILDCASTING", TRUE);
    ClearAllActions();
    if (oTarget == OBJECT_INVALID)
    {
        oTarget = GetNearestObjectToLocation(OBJECT_TYPE_CREATURE, lLocation);
    }
    AssignCommand(oCaster, ActionCastSpellAtObject(nSpell, oTarget,
                           nMetaMagic, TRUE, nCasterLevel,
                           PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    DelayCommand(5.5, DeleteLocalInt(oCaster, "WILDCASTING"));
}

// To do: Get a better random spell chooser
void RandomCast ()
{
    object oTarget = GetRandomNearby(OBJECT_SELF);
    location lLocation = GetLocation(oTarget);
    SpecialCast(Random(412), oTarget, lLocation,
                GetCasterLevel(OBJECT_SELF), GetMetaMagicFeat());
}

object GetRandomNearby(object oTarget=OBJECT_SELF)
{
    object oNewTarget;
    int nCounter = 0;
    int nType;
    while (1)
    {
        oNewTarget = GetNearestObject(OBJECT_TYPE_ALL, oTarget, nCounter);
        nType = GetObjectType(oNewTarget);
        if ((nType == OBJECT_TYPE_CREATURE ||
             nType == OBJECT_TYPE_PLACEABLE) &&
             d8() == 1)
        {
            break; // Target selected
        }
        if (nCounter++ > 20)
        {
            oNewTarget = oTarget;
            break; // Did not find random target, choose self as default
        }
    }
    return oNewTarget;
}

effect EffectWildMagicAOE()
{
    int nAOE = AOE_PER_FOGKILL;
    return EffectAreaOfEffect(nAOE, "wm_aoe_e", "wm_aoe_h", "wm_aoe_x");
}

effect EffectNullMagicAOE()
{
    int nAOE =AOE_PER_FOGMIND;
    return EffectAreaOfEffect(nAOE, "nm_aoe_e", "nm_aoe_h", "nm_aoe_x");
}

void RemoveMagicalEffects (object oTarget)
{
    effect eEffect = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eEffect)) {
        if (GetEffectSubType(eEffect) == SUBTYPE_MAGICAL)
        {
            RemoveEffect(oTarget, eEffect);
        }
        eEffect = GetNextEffect(oTarget);
    }
}
//::////////////////////////////////////////////////////////////////////////////
