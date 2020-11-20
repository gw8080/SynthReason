PrintWriter outputx;
String resource = "reason.txt";
void setup()
{
  String str2 = "";
  String[] KB = loadStrings(resource);
  for (int i = 0; i != KB.length; i++)
  {
    str2 += KB[i];
  }
  String[] knowledge = split(str2, " ");
  String str3 = "";
  KB = loadStrings("mind.txt");
  for (int i = 0; i != KB.length; i++)
  {
    str3 += KB[i] + "\n";
  }
  String[] spectrumFeed = split(str3, "\n");
  String spectrum = "";
  for (int i = 0; i != spectrumFeed.length-1; i++)
  {
    for (int i2 = 0; i2 != spectrumFeed.length-1; i2++)
    {
      if (spectrumFeed[i] != spectrumFeed[i2]) {
        spectrum += spectrumFeed[i] + " " + spectrumFeed[i2] + ",";
      }
    }
  }

  String[] spectrumA = split(spectrum, ",");
  int[] prob;
  prob = new int[spectrumA.length];
  for (int i = 0; i != spectrumA.length; i++)
  {
    prob[i] = 0;
  }

  for (int a = 0; a < spectrumA.length-1; a++) {
    String[] spec = split(spectrumA[a], " ");
    for (int b = 0; b < knowledge.length; b++) {
      if (knowledge[b].indexOf(spec[0]) < knowledge[b].indexOf(spec[1])) {
        prob[a] = prob[a] + 1;
      }
    }
  }

  String str4 = "";
  for (int x = 0; x != prob.length; x++)
  {
    str4 += prob[x] + ",";
  }
  outputx = createWriter("output/model.txt");
  outputx.println(spectrum);
  outputx.println("::");
  outputx.println(str4);
  outputx.flush();
  outputx.close();
 
  //spectrumout = spectrumout.replace("cognition ", "");
  //spectrumout = spectrumout.replace("reason ", "");
  //spectrumout = spectrumout.replace("  ", " ");

  outputx = createWriter("output/modelout.txt");
  outputx.println(spectrumout);
  outputx.flush();
  outputx.close();

  exit();
}
