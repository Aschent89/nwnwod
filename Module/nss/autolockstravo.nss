void main()
{
    ActionWait(0.0); // Pause fifteen seconds.
    SetLocked(OBJECT_SELF, TRUE);  // Lock door.
    PlaySound("gui_picklockfail");  // Play sound.
}

