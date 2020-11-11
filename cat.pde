PrintWriter outputx;

int poss = 15;
int chunksize = 30;
void setup()
{
  String resource = "uber.txt";
  String[] coolw = loadStrings("problem.txt");
  String coolstr = "";
  for (int i = 0; i < coolw.length; i++)
  {
    coolstr += coolw[i] + "\n";
  }
  String[] coolwords = split(coolstr, "\n");
  String str = "";
  String[]KB = loadStrings(resource);
  for (int i = 0; i < KB.length; i++)
  {
    str += KB[i];
  }

  String stre = "";
  String[] solve = loadStrings("solve.txt");
  for (int i = 0; i < solve.length; i++)
  {
    stre += solve[i] + "\n";
  }
  String[]sol = stre.split("\n");
  String[]enx = split(str, " ");
  String cool = "";
  for (int x = 0; x < enx.length; x++)
  {

    if (enx[x].length() > 5) {
      cool += enx[x] + "\n";
    }
  }


  String[] sentence = split(str, ".");

  for (int loop = 0; loop < coolwords.length; loop++) {
    String string = "";
    for (int u = 0; u < sentence.length; u++) {
      for (int a = 0; a < sol.length; a++)
      {


        if (sentence[u].indexOf(" " + coolwords[loop] + " ") > -1 && sentence[u].indexOf(sol[a]) > -1) {
          string += sentence[u] + ".\n\n";
          break;
        }
      }
    }
    outputx = createWriter("output/" + coolwords[loop] + ".txt");
    outputx.println(string);
    outputx.println();
    outputx.println();
    outputx.flush();
    outputx.close();
  }

  exit();
}
