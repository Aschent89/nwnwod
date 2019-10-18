void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC, "MR_REST_FLAG", 1);
    AssignCommand(oPC, ActionRest());
}
