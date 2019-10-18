//place this in the onopen event of doors

void main()
{
   DelayCommand(20.0, ActionCloseDoor(OBJECT_SELF));
}
