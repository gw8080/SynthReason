PrintWriter outputx;
String resource = "encyclopedia.txt";
int chunksize = 5;
int num = 100;
int mode = 3;
void setup()
{
  String str2 = "";
  String[] KB = loadStrings(resource);
  for (int i = 0; i != KB.length; i++)
  {
    str2 += KB[i];
  }

  String spectrum = "";
  if (mode == 0) {
    String[] du = split(str2, " ");
    for (int count = 0; count != num; count++) {
      float r3 = random(du.length-1);
      int x = round(r3);
      spectrum += du[x] + " " + du[x+1] + " ";
    }
  }
  if (mode == 1) {
    String str3 = "";
    KB = loadStrings("1.txt");
    for (int i = 0; i != KB.length; i++)
    {
      str3 += KB[i] + "\n";
    }
    String[] hook = split(str2, " ");
    for (int a = 0; a < hook.length; a++) {
      if (str3.indexOf("\n" + hook[a] + "\n") > -1) {
        spectrum += hook[a] + " ";
      }
    }
  }
  if (mode == 2) {
    String str3 = "";
    KB = loadStrings("7.txt");
    for (int i = 0; i != KB.length; i++)
    {
      str3 += KB[i] + "\n";
    }
    String[] hook = split(str3, "\n");
    for (int a = 0; a < hook.length; a++) {
      if (str2.indexOf(" " + hook[a] + " ") > -1) {
        spectrum += hook[a] + " ";
      }
    }
  }
  if (mode == 3) {
    String str3 = "";
    KB = loadStrings("3.txt");
    for (int i = 0; i != KB.length; i++)
    {
      str3 += KB[i] + "\n";
    }
    String[] hook = split(str3, "\n");
    for (int a = 0; a < num; a++) {
      float r3 = random(hook.length-1);
      int x = round(r3);
      if (str2.indexOf(" " + hook[x] + " ") > -1) {
        spectrum += hook[x] + " ";
      }
    }
  }
  String[] eny = split(spectrum, " ");// guide
  String[] enz = split(str2, " ");// full
  for (int j = 0; j != eny.length - chunksize - 1; j++) {
    for (int i = 0, a = chunksize; i != enz.length - chunksize - 1; i++) {
      String outputr = "";
      for (int f = 0; f != a; f++) {
        outputr += enz[i+f] + "$^$";
        if (spectrum.indexOf(eny[j] + " " + enz[i+f]) > -1) {
          spectrum = spectrum.replace(" " + eny[j] + " " + enz[i+f] + " ", " " + eny[j] + " " +  outputr + " " + eny[j+1] + " ");
          break;
        }
      }
    }
  }
  spectrum = spectrum.replace("$^$", " ");
  spectrum = spectrum.replace("  ", " ");
  String[] spectrumcheck = split(spectrum, " ");
  for (int count = 0; count < spectrumcheck.length; count++) {
    spectrum = spectrum.replace(spectrumcheck[count] + " " + spectrumcheck[count] + " ", spectrumcheck[count] + " ");
  }
  outputx = createWriter("output/test.txt");
  outputx.println(spectrum);
  outputx.flush();
  outputx.close();
  exit();
}
