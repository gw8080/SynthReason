PrintWriter outputx;
int num = 10; // number of files to generate
void setup()
{
  String resource = "int.txt";
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
    String[]vocabprep = vocabsyn.split(":::::");
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
    str = "";
    KB = loadStrings(resource);
    for (int i = 0; i < KB.length; i++)
    {
      str += KB[i];
    }
    String[]en = str.split(" ");
    String[]cat = txt.split(",");
    float r2 = 0;
    int x = round(r2);
    String[] outputl = split(output, " ");
    String[] searchparam = outputl;
    for (int b = 0; b < cat.length - 10; b++)
    {
      outputl = split(output, " ");
      searchparam = outputl;
      float r = random(en.length-10);
      for (int i = round(r); i < en.length-10; i++)
      {
        if (vocabprep[int (cat[b])].indexOf("\n" + en[i] + "\n") > -1 && str.indexOf(outputl[outputl.length-1] + " " + en[i] + " ") > -1)
        {
          r2 = random(searchparam.length-1);
          x = round(r2);
          if (en[i-1].indexOf(searchparam[x]) > -1) {
            r2 = random(10);
            int a = round(r2);
            for (int f = 0; f < a; f++) {
              outputl = split(output, " ");
              searchparam = outputl;
              output += en[i+f] + " ";
              if (vocabprep[4].indexOf("\n" + en[i+f] + "\n") > -1 ) {
                break;
              }
            }
            b+= a;
          }
          r = random(en.length-5);
          i = round(r);    
          break;
        }
      }
    }
    output = output.replace(" and .", ".");
    output = output.replace(" than .", ".");
    output = output.replace(" any .", ".");
    output = output.replace(" the .", ".");
    output = output.replace(" has .", ".");
    output = output.replace(" a .", ".");
    output = output.replace(" to .", ".");
    output = output.replace(" only .", ".");
    output = output.replace(" they .", ".");
    output = output.replace(" of .", ".");
    output = output.replace(" is .", ".");
    output = output.replace(" which .", ".");
    output = output.replace(" in .", ".");
    outputx = createWriter("output/output#" + loop + ".txt");
    outputx.println(output);
    outputx.println();
    outputx.println();
    outputx.flush();
    outputx.close();
  }
  exit();
}
