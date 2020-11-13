PrintWriter outputx;
String resource = "uber.txt";
int chunksize = 10;
int num = 100;
void setup()
{
  String str2 = "";
  String[] KB = loadStrings(resource);
  for (int i = 0; i < KB.length; i++)
  {
    str2 += KB[i];
  }
  String[] du = split(str2, " ");
  String spectrum = "";
  for (int count = 0; count < num; count++) {
    float r3 = random(du.length-1);
    int x = round(r3);
    spectrum += du[x] + " " + du[x+1] + " ";
  }
  String[] eny = split(spectrum, " ");// guide
  String[] enz = split(str2, " ");// full
  float r = random(eny.length-chunksize-1);
  float r2 = random(enz.length-chunksize-1);
  for (int j = round(r); j < eny.length - chunksize - 1; j++) {
    for (int i = round(r2); i < enz.length - chunksize - 1; i++) {
      int a = chunksize;
      String outputr = "";
      for (int f = 0; f != a; f++) {
        outputr += enz[i+f] + "$^$";
        if (spectrum.indexOf(eny[j] + " " + enz[i+f]) > -1) {
          spectrum = spectrum.replace(" " + eny[j] + " " + enz[i+f] + " ", " " + eny[j] + " " +  outputr + " " + eny[j+1] + " ");
          break;
        }
      }
      r = random(eny.length-chunksize-1);
      r2 = random(enz.length-chunksize-1);
      j = round(r);
      i = round(r2);
    }
  }
  spectrum = spectrum.replace("$^$", " ");
  spectrum = spectrum.replace("  ", " ");
  outputx = createWriter("output/test.txt");
  outputx.println(spectrum);
  outputx.flush();
  outputx.close();
  exit();
}
