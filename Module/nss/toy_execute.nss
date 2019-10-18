void main()
{
    object oPC = GetPCSpeaker();
    string sToyTag = GetLocalString(oPC, "MR_TOY_TAG");

    ExecuteScript(sToyTag, oPC);
}
