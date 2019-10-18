void main()
{
  object oDoor = GetObjectByTag("Wall1Gate");

  AssignCommand(oDoor, ActionOpenDoor(oDoor));
}

