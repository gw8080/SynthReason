PrintWriter outputx;
PrintWriter outputx2;
PrintWriter outputx3;
PrintWriter outputz;
PrintWriter outputp;

void setup()
{
  String[] memory = loadStrings("reason.txt");
  String str = "";
  for (int i = 0; i < memory.length; i++)
  {
    str += memory[i] + ".";
  }
  String[] memory2 = split(str, '.');
  String[] activeMote = loadStrings("x.txt");
  str = "";
  for (int i = 0; i < activeMote.length; i++)
  {
    str += activeMote[i] + "\n";
  }
  String[] activeMote2 = split(str, '\n');
  String[] activeProperty = loadStrings("z.txt");
  str = "";
  for (int i = 0; i < activeProperty.length; i++)
  {
    str += activeProperty[i] + "\n";
  }
  String[] activeProperty2 = split(str, '\n');
  outputx = createWriter("mem.txt");
  outputx2 = createWriter("activeMote.txt");
  outputx3 = createWriter("activeProperty.txt");
  String workingMemory = "";
  for (int mem = 0; mem < memory2.length; mem++) {
    String activeMemory2 = memory2[mem];
    for (int z = 0; z < activeProperty2.length; z++) {

      for (int x = 0; x < activeMote2.length; x++) {

        if (activeMemory2.indexOf(" " + activeMote2[x] + " ") > -1 && activeMemory2.indexOf(" " + activeProperty2[z] + " ") > -1) {
          String am = activeMote2[x];
          String ap = activeProperty2[z];
          workingMemory += "|" + mem + "|" + ap + "|" + am + "\n";
          outputx.println(mem);
          outputx.flush();
          outputx2.println(activeMote2[x]);
          outputx2.flush();
          outputx3.println(activeProperty2[z]);
          outputx3.flush();
        }
      }
    }
  }



  outputz = createWriter("test.txt");
  outputz.println(workingMemory);
  outputz.flush();
  outputz.close();
  outputx.close();
  outputx2.close();
  outputx3.close();


  String[] load = loadStrings("activeProperty.txt");
  String[] loadMote = loadStrings("activeMote.txt");
  String[] test = loadStrings("test.txt");
  str = "";
  String test2 = "";
  for (int i = 0; i < test.length-1; i++)
  {
    test2 += test[i] + "\n";
  }
  for (int x = 0; x < load.length-1; x++) {
    outputp = createWriter(load[x] + ".txt");
    for (int y = 0; y < loadMote.length-1; y++) {

      if (test2.indexOf("|" + load[x] + "|" + loadMote[y]) > -1) {
        outputp.println(loadMote[y]);
      }
    }
    outputp.flush();
    outputp.close();
  }

  exit();
}
