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

    if (output.length() > 10) {
      if (learnMode == 0) {
        output = output.replace("\n", ".\n\n");
        outputx = createWriter("output/" + loop + ".txt");
        outputx.println(output);
        outputx.println();
        outputx.println();
        outputx.flush();
        outputx.close();
      }
      if (learnMode == 1) {
        output = output.replace(" ", "\n");
        outputx = createWriter("output/" + loop + ".txt");
        outputx.println(output);
        outputx.println();
        outputx.println();
        outputx.flush();
        outputx.close();
      }
    }
  }


  int count2 = 0;
  String[]memory;
  String memorysyn = "";
  for (count = 0; count2 < num; count2++)
  {
    memory = loadStrings("output/" + count2 + ".txt");
    if (memory != null)
    {
      String voc = join(memory, '\n');
      if (voc.length() > 0)
      {
        memorysyn += voc + ":::::";
      }
      if (voc.length() == 0)
      {
        break;
      }
    }
  }
  String[]memoryarray = split(memorysyn, ":::::");


  for (int outcount = 0; outcount < num; outcount++) {
    String out = "";
    for (int e = 0; e != memoryarray.length; e++) {
      String[] sentence = split(memoryarray[e], ".");
      for (int f = 0; f != sentence.length; f++) {
        float r = random(sentence.length-1);
        f = round(r);
        if (sentence[f].length() < 128 && sentence[f].length() > 64) {
          out += sentence[f] + ".\n";
          break;
        }
      }
    }
    outputx = createWriter("outputR/" + outcount + ".txt");
    outputx.println(out);
    outputx.flush();
    outputx.close();
  }
  exit();
}
