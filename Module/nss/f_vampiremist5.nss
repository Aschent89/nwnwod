void main()
{
location lTarget = GetLocalLocation(OBJECT_SELF, "VAMPIRE_MIST_TARGET");
DeleteLocalLocation(OBJECT_SELF, "VAMPIRE_MIST_TARGET");
if(GetArea(OBJECT_SELF) == GetAreaFromLocation(lTarget))
    {
    FadeToBlack(OBJECT_SELF, FADE_SPEED_FASTEST);
    DelayCommand(0.5, JumpToLocation(lTarget));
    DelayCommand(1.0, FadeFromBlack(OBJECT_SELF, FADE_SPEED_FASTEST));
    }
else JumpToLocation(lTarget);
}
