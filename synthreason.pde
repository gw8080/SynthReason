PrintWriter outputx;
int num = 10; // number of files to generate
void setup()
{
  String resource = "n.txt";
  String rules = "reason.txt";
  for (int loop = 0; loop < num; loop++) {
    String output = "";
    String txt = "";
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
    String str = "";
    String[]KB = loadStrings(rules);
    for (int i = 0; i < KB.length; i++)
    {
      str += KB[i];
    }
    String[]enx = split(str, " ");
    String[]vocabprep = split(vocabsyn, ":::::");
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
    String[]en = split(str2, " ");
    String[]cat = split(txt, ",");
    float r2 = 0;
    String[] outputl = split(output, " ");
    for (int b = 1; b < cat.length - 10; b++)
    {
      outputl = split(output, " ");
      float r = random(en.length-20);
      for (int i = round(r); i < en.length-10; i++)
      {
        if (vocabprep[int (cat[b])].indexOf("\n" + en[i] + "\n") > -1 && str2.indexOf(outputl[outputl.length-1] + " " + en[i] + " ") > -1 && vocabprep[int (cat[b])].indexOf(outputl[outputl.length-1]) > -1)
        {
          r2 = random(15);
          int a = round(r2);
          for (int f = 0; f < a; f++) {
            output += en[i+f] + " ";
            if (vocabprep[1].indexOf("\n" + en[i+f] + "\n") > -1 ) {
              a = f;
              break;
            }
          }
          b+= a;
          r = random(en.length-5);
          i = round(r);    
          break;
        }
      }
    }
    outputx = createWriter("output/output#" + loop + ".txt");
    outputx.println(output);
    outputx.println();
    outputx.println();
    outputx.flush();
    outputx.close();
  }
  exit();
}
