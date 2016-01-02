void main()
{
SendMessageToPC(GetPCSpeaker(), "The spawner has been deleted.");
DestroyObject(GetObjectByTag("dm_spawner_easy"));
DestroyObject(GetObjectByTag("dmwp_spawner_easy"));
}
