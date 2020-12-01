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
    for (int i2 = 0; i2 != spectrumFeed.length-1; i2++)
    {
      spectrumx += spectrumFeed[i] + " " + spectrumFeed[i2] + ",";
    }
    outputx.print(spectrumx);
    outputx.flush();
    spectrumx = "";
  }


  outputx.close();
  exit();
}
