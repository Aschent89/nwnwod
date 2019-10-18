//::///////////////////////////////////////////////
//:: FileName s_pcl_teleport
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/3/2002 1:13:27 PM
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    object oLeader = GetFactionLeader(oPC);

    if (oLeader != oPC) {

        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oPC);
        AssignCommand(oPC, JumpToObject(oLeader));

    } else {

        SendMessageToPC(oPC, "You are the party leader!");

    }
}
