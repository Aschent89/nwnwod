int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetStringLowerCase(GetSubRace(oPC)) != "garou_lupis") return FALSE;

return TRUE;
}

