/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetStringLowerCase(GetSubRace(oPC)) != "kinfolk_lupis") return FALSE;

return TRUE;
}
