void main()
{
object oPC = GetItemActivator();
location lLiftoff = GetLocation (oPC);
int iNorth = 0;
int iEast = 0;
vector vPC = GetPosition(oPC);
object oLiftoff = GetArea(oPC);
if (GetLocalString(oLiftoff,"state")== "normal")
   {
string sXYTag = GetLocalString(oLiftoff,"tag");
string sXYState = GetLocalString(oLiftoff,"state");
string sLiftoff  = GetStringLowerCase(GetTag(GetArea(oPC)));
object oLanding = GetObjectByTag(sXYTag+"umbra");
float fOrientation = GetFacingFromLocation(GetLocation(oPC));
location lLanding = Location(oLanding, vPC, fOrientation);
if (sXYState == "normal")
{
AssignCommand(oPC, ClearAllActions(TRUE));
AssignCommand(oPC, ActionJumpToLocation(lLanding));
FloatingTextStringOnCreature("*You feel yourself slipping into a realm with the feelings of the normal world fading away.*", oPC, FALSE);
   }
   }
if (GetLocalString(oLiftoff,"state")== "umbra")
   {
string sXYTag = GetLocalString(oLiftoff,"tag");
string sXYState = GetLocalString(oLiftoff,"state");
string sLiftoff  = GetStringLowerCase(GetTag(GetArea(oPC)));
object oLanding = GetObjectByTag(sXYTag+"normal");
float fOrientation = GetFacingFromLocation(GetLocation(oPC));
location lLanding = Location(oLanding, vPC, fOrientation);

if (sXYState == "umbra")
{
AssignCommand(oPC, ClearAllActions(TRUE));
AssignCommand(oPC, ActionJumpToLocation(lLanding));
FloatingTextStringOnCreature("*The realm of the spirits fades from your sight as you slip through the vail and you return to the normal realm*", oPC, FALSE);
   }
   }
}
