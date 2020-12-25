PrintWriter outputx;
PrintWriter outputz;
String mind = "vocab.txt";

void setup()
{
  String str3 = "";
  String[] KB = loadStrings(mind);
  for (int i = 0; i != KB.length; i++ )
  {
    str3 += KB[i] + "\n";
  }
  String[] spectrumFeed = split(str3, "\n");


  outputx = createWriter("output/turing.txt");
  for (int i = 0; i != spectrumFeed.length-1; i++)
  {
    outputz = createWriter("output/progress.txt");
    outputz.println(i + "/" + spectrumFeed.length);
    outputz.close();
    String spectrumx = "";
    String[] knowledge = loadResourcesA("text.txt");
    for (int i2 = 0; i2 != spectrumFeed.length-1; i2++)
    {
      for (int x = 0; x < knowledge.length; x++) {
        if (knowledge[x].indexOf(spectrumFeed[i]) < knowledge[x].indexOf(spectrumFeed[i2]) && knowledge[x].indexOf(spectrumFeed[i]) >-1 && knowledge[x].indexOf(spectrumFeed[i2]) >-1) {
          spectrumx += spectrumFeed[i] + " " + spectrumFeed[i2] + ",";
          break;
        }
      }
    }

    outputx.print(spectrumx);
    outputx.flush();
    spectrumx = "";
  }
  outputx.close();
  exit();
}
String[] loadResourcesA(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  String[] str3 = split(str2, ".");
  return str3;
}
