void main()
{
object oPC = GetPCSpeaker();
SetLocalLocation(oPC, "FALLEN_VAMPIRE_DESTINATION", GetLocation(GetLocalObject(oPC, "FALLEN_VAMPIRE_COFFIN")));
ExecuteScript("f_vampirebat6", oPC);
}
