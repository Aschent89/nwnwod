void main()
{
object oPC = GetPCSpeaker();
SetLocalLocation(oPC, "FALLEN_VAMPIRE_DESTINATION", GetLocalLocation(oPC, "FALLEN_VAMPIRE_MARK"));
ExecuteScript("f_vampirebat6", oPC);
}
