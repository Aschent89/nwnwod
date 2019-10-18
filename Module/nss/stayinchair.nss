void main()
{
	object oChair = GetNearestObjectByTag("Chair2");
	//Make sure no one is in chair, if not sit-down.
	if(!GetIsObjectValid(GetSittingCreature(oChair)))
	  {
	  ClearAllActions(); //This is so he don't spin in his chair, following you.
	  ActionSit(oChair);
	  }
}
//End
