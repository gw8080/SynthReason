PrintWriter outputx;

int poss = 150;
int chunksize = 10;
void setup()
{
  String resource = "n.txt";
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
  int num = 10, e = 0; 
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
    String[] coolwords = split(cool, "\n");
    num = coolwords.length;
    for (int i = 0; i < KB.length; i++)
    {
      if (KB[i].indexOf(" " + coolwords[loop] + " ") > -1) {
        str2 += KB[i];
      }
    }
    String[]en = split(str2, " ");
    String[]cat = split(txt, ",");
    float r2 = 0;
    float r = random(en.length-chunksize);
    int i = round(r);
    for (int b = 1; b < cat.length - chunksize; b++)
    {

      String outputmulti = "";
      for (i = i; i < en.length-chunksize; i++)
      {
        if (i > en.length-chunksize) {
          r = random(en.length-chunksize);
          i = round(r);
        }
        String[] outputl = split(output, " ");
        outputl = split(output, " ");
        if (vocabprep[int (cat[b])].indexOf("\n" + en[i-1] + "\n") > -1 && vocabprep[int (cat[b])].indexOf(outputl[outputl.length-1]) > -1 && outputl[outputl.length-1].indexOf( en[i]) > -1);
        {
          for (int multi = 0; multi < poss; multi++) {
            r2 = random(chunksize);
            int a = round(r2);
            for (int f = 0; f != a; f++) {
              outputmulti += en[i+f] + " ";
              if (vocabprep[2].indexOf("\n" + en[i+f] + "\n") > -1) {
                break;
              }
            }
            outputmulti += ":::::";
          }
          String[]outputarray = split(outputmulti, ":::::");
          for (int n = 0; n != outputarray.length; n++) {
            if (e > coolwords.length-chunksize) {
              e = 0;
            }
            if (n > outputarray.length-chunksize) {
              e++;
            }

            String[] words = split(outputarray[n], " ");
            if (output.indexOf(outputarray[n]) == -1 && outputarray[n].length() > 25 &&  outputarray[n].indexOf(coolwords[e]) > -1) {
              output += outputarray[n];
              i+=outputarray[n].length();
              e++;
              b += outputarray[n].length();
              break;
            }
          }
          break;
        }
      }
    }
    for (int k = 0; k < eliminate.length; k++) {
      output = output.replace(eliminate[k], "");
    }
    if (output.length() > 10) {
      output = output.replace("the is", "is");
      output = output.replace("and to", "and");
      outputx = createWriter("output/" + coolwords[loop] + ".txt");
      outputx.println(output + "is " + coolwords[loop] + ".");
      outputx.println();
      outputx.println();
      outputx.flush();
      outputx.close();
    }
  }
  exit();
}
