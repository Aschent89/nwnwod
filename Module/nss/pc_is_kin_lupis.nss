int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetStringLowerCase(GetSubRace(oPC)) != "kinfolk_lupis") return FALSE;

return TRUE;
}

