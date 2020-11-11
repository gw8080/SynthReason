PrintWriter outputx;
String resource = "uber.txt";
String rules = "reason.txt";
int chunksize = 5;
int learnMode = 0;
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
    String[] coolwords = split(vocabprep[0], "\n");
    for (int i = 0; i < KB.length; i++)
    {
      if (KB[i].indexOf(" " + coolwords[loop] + " ") > -1) {
        str2 += KB[i];
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
            if (en[i+f].length() > 4 && learnMode == 1) {
              output += en[i+f] + " ";
              search = en[i+f];
            }
            if (learnMode == 0) {
              search = en[i+f];
              output += en[i+f] + " ";
            }
          }
          r = random(en.length);
          i = round(r);
          break;
        }
        search = en[i];
      }
    }
    String[] eliminate2 = {"[", "]", ",", "\"", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "(", ")", "\'", "?"};
    for (int k = 0; k < eliminate2.length; k++) {
      output= output.replace(eliminate2[k], "");
    }
    output = output.replace(".", "\n");
    String[] coolx = split(output, " ");
    String coolstr = "";
    for (int i = 0; i < coolx.length; i++)
    {
      coolstr += coolx[i] + " ";
    }
    enx = split(coolstr, " ");
    str = "";
    str2 = "";
    for (int x = 0; x < enx.length; x++)
    {
      if (enx[x].length() > 4) {
        str += enx[x] + " ";
      }
      str2 += enx[x] + " ";
    }
    String[] eny = split(str, " ");// guide
    String[] enz = split(str2, " ");// full
    float r = random(eny.length-chunksize);
    float r2 = random(enz.length-chunksize);
    for (int j = round(r); j < eny.length - chunksize - 1; j++) {
      for (int i = round(r2); i < enz.length - chunksize - 1; i++) {
        int a = chunksize;
        String outputr = "";
        for (int f = 0; f != a; f++) {
          outputr += enz[i+f] + " ";
          if (str.indexOf(enz[i+f]) > -1) {
            str = str.replace( eny[j] + " " + eny[j+1], eny[j] + " " +  outputr + " " + eny[j+1]);
            break;
          }
        }
        r = random(eny.length-chunksize);
        r2 = random(enz.length-chunksize);
        j = round(r);
        i = round(r2);
      }
    }
    if (output.length() > 10) {
      str = str.replace("\n", ".\n\n");
      str = str.replace("  ", " ");

      outputx = createWriter("output/" + loop + ".txt");
      outputx.println(str);
      outputx.println();
      outputx.println();
      outputx.flush();
      outputx.close();
    }
  }
  exit();
}
