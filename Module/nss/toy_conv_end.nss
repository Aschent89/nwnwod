void main()
{
    object oPC = GetPCSpeaker();
    DeleteLocalString(oPC, "MR_TOY_TAG");
    DeleteLocalString(oPC, "MR_TOY_NAME");
    DeleteLocalObject(oPC, "MR_TOY_OWNER");

}
