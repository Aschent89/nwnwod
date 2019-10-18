//::///////////////////////////////////////////////
//:: Falling Rock Trap
//:: ttrap_fallrock
//:://////////////////////////////////////////////
/*
    Falling rock trap.
    Uses placeables object and visuals.

    Damage is taken from variable 'TTRAP_DAMAGE'
    string that takes form of a dice roll
    Default damage is "2d6"

    Saving throw DC against the falling rock is
    taken from the variable 'TTRAP_DC' integer.
    Default DC is 15

    Player is stunned for a set rounds that is
    taken from the variable 'TTRAP_STUNROUNDS'
    Default 2
*/
//:://////////////////////////////////////////////
//:: Created By: TOJ
//:: Created On: Fall 2004
//:://////////////////////////////////////////////

#include "ttrap_common"

void main()
{
    // affected creature
    object o = GetEnteringObject();
    // placeable spawned (falling rock)
    string boulderResRef = "plc_boulder";
    // visual effect
    effect vfx = EffectVisualEffect(354);
    // reflex DC
    int dc = GetLocalInt(OBJECT_SELF, "TTRAP_DC");


    // reflex save versus trap
    if (ReflexSave(o, dc, SAVING_THROW_TYPE_TRAP)==0)
    {
        // failed reflex save :(
        // get damage roll
        string damageRoll = GetLocalString(OBJECT_SELF, "TTRAP_DAMAGE");
        // do damage roll
        int damage = RollDices(damageRoll);
        // stun rounds
        int stunRounds = GetLocalInt(OBJECT_SELF, "TTRAP_STUNROUNDS");

        // damage the creature
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(damage, DAMAGE_TYPE_BLUDGEONING), o);
        // stun the creature
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), o, RoundsToSeconds(stunRounds));
    }
    else
    {
        AssignCommand(o, PlayAnimation(ANIMATION_FIREFORGET_DODGE_SIDE));
    }

    // apply visuals
    ApplyEffectToObject(DURATION_TYPE_INSTANT, vfx, o);
    // place boulder
    CreateObject(OBJECT_TYPE_PLACEABLE, boulderResRef, GetLocation(o));
}
