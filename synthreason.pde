PrintWriter outputx;
String resource = "uber.txt";
String rules = "int.txt";
int chunksize = 1;
int chunksize2 = 10;
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
    String[] coolwords = split(vocabprep[2], "\n");
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
    String spectrum = "";
    String[]spec = loadStrings("spectrum.txt");
    for (int i = 0; i < spec.length; i++)
    {
      spectrum += spec[i];
    }
    String[] eny = split(str, " ");// guide
    String[] enz = split(str2, " ");// full
    float r = random(eny.length-chunksize2);
    float r2 = random(enz.length-chunksize2);
    for (int j = round(r); j < eny.length - chunksize2 - 1; j++) {
      for (int i = round(r2); i < enz.length - chunksize2 - 1; i++) {
        int a = chunksize2;
        String outputr = "";
        for (int f = 0; f != a; f++) {
          outputr += enz[i+f] + "$^$";
          if (str.indexOf(eny[j] + " " + enz[i+f]) > -1 && enz[i+f] == eny[j+1]) {
            str = str.replace(" " + eny[j] + " " + enz[i+f] + " ", " " + eny[j] + " " +  outputr + " " + eny[j+1] + " ");
            break;
          }
        }
        r = random(eny.length-chunksize2);
        r2 = random(enz.length-chunksize2);
        j = round(r);
        i = round(r2);
      }
    }
    if (output.length() > 10) {
      str = str.replace("\n", ".\n\n");
      str = str.replace("  ", " ");
      str = str.replace("$^$", " ");
      outputx = createWriter("output/" + coolwords[loop]+ ".txt");
      outputx.println(str);
      outputx.println();
      outputx.println();
      outputx.flush();
      outputx.close();
    }
  }
  exit();
}
