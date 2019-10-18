void JUMP(object oPC, location lLoc)
{
    AssignCommand(oPC, ClearAllActions(FALSE));
    AssignCommand(oPC, ActionJumpToLocation(lLoc));
}

void main()
{
    //Get the local variables
    object oMaster = GetPCSpeaker();;
    object oSlave = GetLocalObject(oMaster, "MR_COLLAR_SLAVE");
    object oLeash = GetLocalObject(oMaster, "MR_COLLAR_LEASH");
    object oCollar = GetLocalObject(oMaster, "MR_COLLAR_COLLAR");

    //Define the two strings
    string sSlaveName = GetName(oSlave);
    string sMasterName = GetName(oMaster);
    string sSlave = sMasterName + " has summoned you!";
    string sMaster = "You have summoned " + sSlaveName;

    //Define the two visual effects and locations
    effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    effect eUnSummon = EffectVisualEffect(VFX_IMP_UNSUMMON);
    location lMaster = GetLocation(oMaster);
    location lSlave = GetLocation(oSlave);

    //Send the messages
    FloatingTextStringOnCreature(sSlave, oSlave, FALSE);
    FloatingTextStringOnCreature(sMaster, oMaster, FALSE);

    //Port the slave.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eUnSummon, lSlave);
    JUMP(oSlave, lMaster);

    //Brief delay to compensate for time to transition then apply the VFX for the
    //master
    DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, lMaster));


    //Clear the stored data.
    DeleteLocalObject(oMaster, "MR_COLLAR_SLAVE");
    DeleteLocalObject(oMaster, "MR_COLLAR_LEASH");
    DeleteLocalObject(oMaster, "MR_COLLAR_COLLAR");
}
