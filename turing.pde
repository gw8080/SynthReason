PrintWriter outputx;
PrintWriter outputz;
String mind = "2.txt";

void setup()
{
  String str3 = "";
  String[] KB = loadStrings(mind);
  for (int i = 0; i != KB.length; i++ )
  {
    str3 += KB[i] + "\n";
  }
  String[] spectrumFeed = split(str3, "\n");

  String spectrumx = "";
  for (int i = 0; i != spectrumFeed.length-1; i++)
  {
    for (int i2 = 0; i2 != spectrumFeed.length-1; i2++)
    {
      spectrumx += spectrumFeed[i] + " " + spectrumFeed[i2] + ",";
    }
  }
  outputx = createWriter("output/turing.txt");
  outputx.println(spectrumx);
  outputx.close();
  exit();
}
