PrintWriter outputx;
String resource = "uber.txt";
String rules = "reason.txt";
int chunksize = 10;
void setup()
{
  int count = 0;
  String[]vocabproc;
  String vocabsyn = "";
  for (count = 0; count < 20; count++)
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
  int num = 10; 
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
    String[] coolwords = split(vocabprep[6], "\n");
    num = coolwords.length;
    for (int i = 0; i < KB.length; i++)
    {
      if (KB[i].indexOf(" " + coolwords[loop] + " ") > -1) {
        str2 += KB[i];
      }
    }
    String[]en = str2.split(" ");
    String[]cat = txt.split(",");
    outputx = createWriter("output.txt");
    for (int b = 0; b < cat.length - chunksize; b++)
    {
      float r = random(en.length);
      for (int i = round(r); i < en.length-chunksize; i++)
      {
        if (vocabprep[int (cat[b])].indexOf("\n" + en[i] + "\n") > -1)
        {
          int a = chunksize;
          for (int f = 0; f != a; f++) {
            output += en[i+f] + " ";
            if (vocabprep[2].indexOf("\n" + en[i+f] + "\n") > -1) {
              b+=f;
              break;
            }
          }
          r = random(en.length);
          i = round(r);
          break;
        }
      }
    }
    String[] eliminate2 = {"[", "]", ",", "\"", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "(", ")", "\'", "?"};
    for (int k = 0; k < eliminate2.length; k++) {
      output= output.replace(eliminate2[k], "");
    }
    output = output.replace(".", " is " + coolwords[loop] + "\n");
    String strfull = "";
    String[] outputl = split(output, "\n");
    for (int xx = 0; xx < coolwords.length; xx++) {
      for (int xxin = 0; xxin < outputl.length; xxin++) {
        if (outputl[xxin].indexOf(coolwords[xx]) > -1) {
          strfull += outputl[xxin] + " of " + coolwords[xx] + ".\n\n";
          break;
        }
      }
    }

    if (output.length() > 10) {
      outputx = createWriter("output/" + coolwords[loop] + ".txt");
      outputx.println(strfull);
      outputx.println();
      outputx.println();
      outputx.flush();
      outputx.close();
    }
  }
  exit();
}
