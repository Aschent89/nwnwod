int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetStringLowerCase(GetSubRace(oPC)) != "kinfolk_homid") return FALSE;

return TRUE;
}

