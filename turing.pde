PrintWriter outputx;
PrintWriter outputz;
PrintWriter outputprog;
int buffer = 102400;
String resource = "uber.txt";
String[] spectrumFeed = new String[0];
void setup()
{
  outputx = createWriter("output/turing.txt");
  String spectrumx = "";
  String[] knowledge = loadResources(resource);
  for (int x = 0; x < knowledge.length-3; x++) {
    spectrumx += knowledge[x] + " " + knowledge[x+1] + ",";
  }
  String[] spectrumA = split(spectrumx, ",");//4
  String full = "";
  outputz = createWriter("output/prob.txt");
  for (int a = 0; a < spectrumA.length-2; a++) {
    int count = 0;
    String[] spec = split(spectrumA[a], " ");
    for (int b = 0; b < knowledge.length-3; b++) {
      if (knowledge[b].equals(spec[0]) == true && knowledge[b+1].equals(spec[1]) == true ) {
        count += 1;
      }
    }
    full += count + ",";
    if (full.length() >= buffer) {
      outputz.print(full);
      outputz.flush();
      outputprog = createWriter("output/progress.txt");
      outputprog.println(a + "/" + spectrumA.length);
      outputprog.close();
      full = "";
    }
  }
  outputz.print(full);
  outputz.close();
  String[] spectrumA2 = split(spectrumx, ",");
  String write = "";
  for (int scan = 0; scan < spectrumA2.length; scan++) {
    if (scan == 0) {
      write += ",";
    }
    if (scan > 0) {
      write += spectrumA2[scan] + ",";
    }
  }
  outputx.print(write);
  outputx.flush();
  outputx.close();
  exit();
}
String[] loadResources(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  String[] str3 = split(str2, " ");
  return str3;
}
String[] initTuring() {
  String[] KB = loadStrings("turing.txt");
  String spectrumx = join(KB, "");
  String[] spectrumA = split(spectrumx, ",");
  return spectrumA;
}
