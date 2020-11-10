PrintWriter outputx;
String resource = "uber.txt";
String rules = "reason.txt";
int chunksize = 1;
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
  String[]vocabprep = split(vocabsyn, ":::::");
  for (int loop = 0; loop < num; loop++) {
    String output = "";    
    String txt = "";
    String str = "";
    String[]KB = loadStrings(rules);
    for (int i = 0; i < KB.length; i++)
    {
      str += KB[i];
    }
    String[]enx = split(str, " ");
    String cool = "";
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
      if (enx[x].length() > 5) {
        cool += enx[x] + "\n";
      }
    }
    String[] eliminate = {"[", "]", ",", ".", "\"", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "(", ")", "\'", "?"};
    for (int k = 0; k < eliminate.length; k++) {
      cool = cool.replace(eliminate[k], "");
    }

    String str2 = "";
    KB = loadStrings(resource);
    for (int i = 0; i < KB.length; i++)
    {
      str2 += KB[i];
    }

    String[] KB2 = split(str2, ".");
    str2 = "";
    String[] coolwords = split(cool, "\n");
    for (int i = 0; i < KB2.length-1; i++)
    {
      if (KB2[i].indexOf(" " + coolwords[loop] + " ") > -1) {
        str2 += KB2[i] + ".";
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
        if (vocabprep[int (cat[b])].indexOf("\n" + search + "\n") > -1)
        {
          int a = chunksize;
          for (int f = 0; f != a; f++) {
            search = en[i+f];
            output += en[i+f] + " ";
          }
          b+=a;
          r = random(en.length);
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
    output = output.replace(".", "\n");

    if (output.length() > 10) {
      output = output.replace("\n", ".\n\n");
      outputx = createWriter("output/" + loop + ".txt");
      outputx.println(output);
      outputx.println();
      outputx.println();
      outputx.flush();
      outputx.close();
    }
  }
  exit();
}
