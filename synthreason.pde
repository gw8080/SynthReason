PrintWriter outputx;

int poss = 15;
int chunksize = 30;
void setup()
{
  String resource = "uber.txt";
  String rules = "uber.txt";

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
  int num = vocabprep[3].length()-1; 
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
    String[] coolwords = split(vocabprep[3], "\n");
    for (int i = 0; i < KB.length; i++)
    {
      if (KB[i].indexOf(coolwords[loop]) > -1) {
        str2 += KB[i];
      }
    }
    String[]en = split(str2, " ");
    String[]cat = split(txt, ",");
    float r2 = 0;

    for (int b = 1; b < cat.length - chunksize; b++)
    {
      float r = random(en.length);
      String outputmulti = "";
      for (int i = round(r); i < en.length-chunksize; i++)
      {
        String[] outputl = split(output, " ");
        outputl = split(output, " ");
        if (vocabprep[int (cat[b])].indexOf("\n" + en[i] + "\n") > -1 && str2.indexOf(outputl[outputl.length-1] + " " + en[i] + " ") > -1 && vocabprep[int (cat[b])].indexOf(outputl[outputl.length-1]) > -1)
        {
          for (int multi = 0; multi < poss; multi++) {
            r2 = random(chunksize);
            int a = round(r2);
            for (int f = 0; f != a; f++) {
              outputmulti += en[i+f] + " ";
              if (vocabprep[5].indexOf("\n" + en[i+f] + "\n") > -1) {
                break;
              }
            }
            outputmulti += ":::::";
            r = random(en.length-chunksize);
            i = round(r);
          }
          String[]outputarray = split(outputmulti, ":::::");
          for (int n = 0; n != outputarray.length; n++) {
            if (outputarray[n].length() > 25) {
              output += outputarray[n];   
              b += outputarray[n].length();
              break;
            }
          }
          break;
        }
      }
    }
    outputx = createWriter("output/" + coolwords[loop] + ":" + loop + ".txt");
    outputx.println(output);
    outputx.println();
    outputx.println();
    outputx.flush();
    outputx.close();
  }
  exit();
}
