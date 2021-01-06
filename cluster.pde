PrintWriter outputz;
PrintWriter outputx;
int num = 30000;
int minimumConnections = 5;
String output = "";
void setup()
{
  String[] resourceA = loadResourcesA("uber.txt");
  String search = loadFilter("filter.txt");
  outputz = createWriter("debugoutput.txt");
  outputx = createWriter("output.txt");
  String[] array = new String[10240000];

  for (int x = 1; x != resourceA.length-2; x++) {
    String[] wordsA = split(resourceA[x], " ");
    for (int y = 0; y != wordsA.length; y++) { // find relative position
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
  float r = random(spectrumA.length-2);
  int chance = round(r);
  String[] spec4 = split(spectrumA[chance], "::");
  for (int count = 0; exit == false; count++) {

    String[] spec = split(spectrumA[chance], "::");
    String[] spec2 = split(spectrumA[chance+1], "::");
    float r2 = random(spectrumA.length-2);
    int chance2 = round(r2);
    String[] spec3 = split(spectrumA[chance2], "::");
    String[] data = loadResourcesB("activeData.txt");
    if (spec.length == 2 && spec2.length == 2 && spec3.length == 2 && spec4.length == 2) {
      if (spec[1].length() > 3 && spec2[0].equals(spec3[0]) == true && activeData(data, spec, spec3) > minimumConnections && activeData(data, spec4, spec) > minimumConnections && activeData(data, spec, spec4) > minimumConnections) {
        output += spec[1] + " " + spec2[0] + " ";
      }
    }
    if (count > num) {
      exit = true;
    }
    r = random(spectrumA.length-2);
    chance = round(r);
  }
  while (output.indexOf("  ") > -1) {
    output = output.replace("  ", " ");
  }  
  outputx.print(output);
  outputx.flush();
  outputx.close();
  exit();
}
int activeData(String[] data, String[] spec1, String[] spec2) {
  int count = 0;
  String string = "";
  for (int x = 0; x != data.length; x++) {
    String[] word = split(data[x], " ");
    for (int y = 0; y != word.length; y++) {
      String[] file = loadStrings("vocab/" + word[y] + ".txt");
      if (file != null) {
        string += join(file, " ") + "::";
      }
    }
  }
  String[] array = split(string, "::");
  if (spec1[1] != null && spec2[1] != null ) {
    String[] xx = split(spec1[1], " ");
    String[] yy = split(spec2[1], " ");
    for (int x = 0; x != xx.length; x++) {
      for (int y = 0; y != yy.length; y++) {
        if (array[0].indexOf(xx[x]) >-1 && array[1].indexOf(yy[y]) >-1) {
          count++;
        }
        if (array[1].indexOf(xx[x]) >-1 && array[0].indexOf(yy[y]) >-1) {
          count++;
        }
      }
    }
  }
  return count;
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
String[] loadResourcesB(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "\n");
  String[] str3 = split(str2, "\n");
  return str3;
}
