//place this in the onopen event of doors

void main()
{
   DelayCommand(8.0, ActionCloseDoor(OBJECT_SELF));
}