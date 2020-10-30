PrintWriter outputx;

int poss = 15;
int chunksize = 30;
void setup()
{
  String resource = "uber.txt";

  String str = "";
  String[]KB = loadStrings(resource);
  for (int i = 0; i < KB.length; i++)
  {
    str += KB[i];
  }
  String[]enx = split(str, " ");
  String cool = "";
  for (int x = 0; x < enx.length; x++)
  {
    if (enx[x].length() > 5) {
      cool += enx[x] + "\n";
    }
  }
  String[] eliminate = {"[", "]", ",", ".", "\"", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "(", ")", "\'", "?",":"};
  for (int k = 0; k < eliminate.length; k++) {
    cool = cool.replace(eliminate[k], "");
  }
  
  KB = loadStrings(resource);
  String[] coolwords = split(cool, "\n");
  for (int loop = 0; loop < coolwords.length; loop++) {
    String str2 = "";
    for (int i = 0; i < KB.length; i++)
    {
      if (KB[i].indexOf(" " + coolwords[loop] + " ") > -1) {
        str2 += KB[i];
      }
    }
    outputx = createWriter("output/" + coolwords[loop] + ".txt");
    outputx.println(str2);
    outputx.println();
    outputx.println();
    outputx.flush();
    outputx.close();
  }
}
