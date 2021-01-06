PrintWriter outputz;
PrintWriter outputx;
int num = 100000;
void setup()
{
  String[] resourceA = loadResourcesA("text.txt");
  String search = loadFilter("filter.txt");
  outputz = createWriter("debugoutput.txt");
  outputx = createWriter("output.txt");
  String[] array = new String[1024000];

  for (int x = 0; x < resourceA.length; x++) {
    String[] wordsA = split(resourceA[x], " ");
    for (int y = 0; y < wordsA.length; y++) { // find relative position
      if (search.indexOf(wordsA[y]) > -1) {
        array[y+(x*100)] = "\n" + wordsA[y] + "::";//set relative position
      }
      if (search.indexOf(wordsA[y]) == -1) {
        array[y+(x*100)] = wordsA[y];//set relative position
      }
    }
  }

  String spectrum = join(array, " ");

  spectrum = spectrum.replace("null ", "");
  String[] spectrumA = split(spectrum, "\n");
  outputz.print(spectrum);
  outputz.flush();
  outputz.close();


  boolean exit = false;
  String output = "";
  for (int count = 0; exit == false; count++) {
    float r = random(spectrumA.length-2);
    int chance = round(r);
    String[] spec = split(spectrumA[chance], "::");
    String[] spec2 = split(spectrumA[chance+1], "::");
    float r2 = random(spectrumA.length-2);
    int chance2 = round(r2);
    String[] spec3 = split(spectrumA[chance2], "::");
    if (spec2[0].equals(spec3[0]) == true) {
      output += spec[1] + " ";
    }
    if (count > num) {
      exit = true;
    }
  }
  while (output.indexOf("  ") > -1) {
    output = output.replace("  ", " ");
  }  
  outputx.print(output);
  outputx.flush();
  outputx.close();
  exit();
}

String loadFilter(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "\n");
  return str2;
}
String[] loadResourcesA(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  String[] str3 = split(str2, ".");
  return str3;
}
