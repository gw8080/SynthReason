PrintWriter outputx;
String resource = "uber.txt";
String rules = "reason.txt";
int chunksize = 15;
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
  int num = 1; 
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


    String[] commandsproc = loadStrings("command.txt");
    String cool = "";
    for (int i = 0; i < commandsproc.length; i++)
    {
      cool += commandsproc[i];
    }
    String[] commands = split(cool, ".");
    String[] coolwords = split(commands[loop], " ");
    num = commands.length-1;
    String str2 = "";
    String cool2 = "";
    for (int i = 0; i < coolwords.length; i++)
    {
      cool2 += coolwords[i] + " ";
    }
    KB = loadStrings(resource);
    for (int i = 0; i < KB.length; i++)
    {
      for (int r = 0; r < coolwords.length; r++)
      {
        if (KB[i].indexOf(" " + coolwords[r] + " ") > -1) {
          str2 += KB[i];
          break;
        }
      }
    }
    String[]en = str2.split(" ");
    String[]cat = txt.split(",");
    outputx = createWriter("output.txt");
    for (int b = 1; b < cat.length - chunksize - chunksize; b++)
    {
      int a = chunksize;
      int a2 = chunksize;
      for (int f = 0; f != a; f++) {
        float r = random(en.length-1);
        for (int i = round(r); i < en.length-chunksize - chunksize; i++)
        {
          String[] outputl = split(output, " ");
          if (vocabprep[int (cat[b+f])].indexOf("\n" + en[i+f] + "\n") > -1 && vocabprep[int (cat[b+f])].indexOf( outputl[outputl.length-1]) > -1 )
          {
            if (int (cat[b+f]) >= 0)
            {
              for (int f2 = 0; f2 != a2; f2++) {
                output += en[i+f2] + " ";
                if (vocabprep[int (cat[b+f])].indexOf(en[i+f2]) >- 1)
                {
                  break;
                }
              }
            }
            break;
          }
        }
      }
      b+=a+a2;
    }
    String[] eliminate2 = {";", "[", "]", ",", "\"", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "(", ")", "\'", "?"};
    for (int k = 0; k < eliminate2.length; k++) {
      output = output.replace(eliminate2[k], "");
      cool2 = cool2.replace(eliminate2[k], "");
    }
    output = output.replace(".", ".\n\n");
    if (output.length() > 10) {
      outputx = createWriter("output/output" + "#" + loop + ".txt");
      outputx.println(output);
      outputx.println();
      outputx.println();
      outputx.flush();
      outputx.close();
    }
  }
  exit();
}
