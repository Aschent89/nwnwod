//::///////////////////////////////////////////////
//:: Common code for cloud trap
//:: ttrap_cloud
//:://////////////////////////////////////////////
/*
    Common functions used by the trap package
*/
//:://////////////////////////////////////////////
//:: Created By: TOJ
//:: Created On: Fall 2004
//:://////////////////////////////////////////////

void main()
{
    // affected creature
    object o = GetEnteringObject();
    // cloud type
    int cloud = GetLocalInt(OBJECT_SELF, "TTRAP_VISUAL");
    // enter script
    string enter = GetLocalString(OBJECT_SELF, "TTRAP_CLOUDENTER");
    // exit script
    string exit = GetLocalString(OBJECT_SELF, "TTRAP_CLOUDEXIT");
    // heartbeat script
    string hb = GetLocalString(OBJECT_SELF, "TTRAP_CLOUDHB");
    // area of effect (cloud)
    effect eAOE = EffectAreaOfEffect(cloud, enter, hb, exit);
    // duration (rounds)
    int rounds = GetLocalInt(OBJECT_SELF, "TTRAP_DURATION");

    // apply cloud effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, GetLocation(o), RoundsToSeconds(rounds));
}
