PrintWriter outputx;
String resource = "uber.txt";
String rules = "reason.txt";
int chunksize = 3;
int num = 100; 
void setup()
{
  int count = 0;
  String[]vocabproc;
  String vocabsyn = "";
  for (count = 0; count < 2000; count++)
  {
    vocabproc = loadStrings(count + ".txt");
    if (vocabproc != null)
    {
      String voc = join(vocabproc, '\n');
      if (voc.length() > 0)
      {
        vocabsyn += voc + ":::::";
      }
      if (voc.length() == 0)
      {
        break;
      }
    }
  }
  String[] coolw = loadStrings("problem.txt");
  String coolstr = "";
  for (int i = 0; i < coolw.length; i++)
  {
    coolstr += coolw[i] + "\n";
  }
  String[] coolwords = split(coolstr, "\n");
  String[]vocabprep = split(vocabsyn, ":::::");
  for (int loop = 0; loop < coolwords.length-1; loop++) {
    String output = "";    
    String txt = "";
    String str = "";
    String[]KB = loadStrings(rules);
    for (int i = 0; i < KB.length; i++)
    {
      str += KB[i];
    }
    String[]enx = split(str, " ");
    for (int x = 0; x < enx.length; x++)
    {
      for (int y = 0; y != vocabprep.length; y++)
      {
        if (vocabprep[y].indexOf("\n" + enx[x] + "\n") > -1)
        {
          txt += y + ",";
          break;
        }
      }
    }
    String str2 = "";
    KB = loadStrings(resource);
    for (int i = 0; i < KB.length; i++)
    {
      str2 += KB[i];
    }
    String[] KB2 = split(str2, ".");
    str2 = "";
    String stre = "";
    String[] solve = loadStrings("solve.txt");
    for (int i = 0; i < solve.length; i++)
    {
      stre += solve[i] + "\n";
    }
    String[]sol = stre.split("\n");
    for (int a = 0; a < sol.length-1; a++)
    {
      for (int i = 0; i < KB2.length-1; i++)
      {
        if (KB2[i].indexOf(" " + coolwords[loop] + " ") > -1 && KB2[i].indexOf(" " + sol[a] + " ") > -1) {
          str2 += KB2[i] + ".";
        }
      }
    }
    String[]en = str2.split(" ");
    String[]cat = txt.split(",");
    outputx = createWriter("output.txt");
    String search = "";
    for (int b = 0; b < cat.length - chunksize; b++)
    {
      float r = random(en.length);
      for (int i = round(r); i < en.length-chunksize; i++)
      {
        if (vocabprep[int (cat[b])].indexOf("\n" + search + "\n") > -1 && search == en[i])
        {
          int a = chunksize;
          for (int f = 0; f != a; f++) {
            search = en[i+f];
            output += en[i+f] + " ";
          }
          b+=a;
          r = random(en.length-chunksize);
          i = round(r);
          break;
        }
        search = en[i+1];
      }
    }
    String[] eliminate2 = {"[", "]", ",", "\"", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "(", ")", "\'", "?"};
    for (int k = 0; k < eliminate2.length; k++) {
      output= output.replace(eliminate2[k], "");
    }


    String[] sentence = split(output, ".");
    String string = "";
    for (int u = 0; u < sentence.length; u++) {
      for (int a = 0; a < sol.length; a++)
      {

        if (sentence[u].indexOf(" " + sol[a] + " ") > -1) {
          string += sentence[u] + ".";
          break;
        }
      }
    }
    if (output.length() > 10) {
      string = string.replace(".", ".\n\n");
      outputx = createWriter("output/" + coolwords[loop] + ".txt");
      outputx.println(string);
      outputx.println();
      outputx.println();
      outputx.flush();
      outputx.close();
    }
  }
  exit();
}
