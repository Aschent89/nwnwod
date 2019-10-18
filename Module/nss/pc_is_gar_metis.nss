int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetStringLowerCase(GetSubRace(oPC)) != "garou_metis") return FALSE;

return TRUE;
}

