PrintWriter outputx;
PrintWriter outputz;
PrintWriter outputy;
PrintWriter outputw;
String resource = "text.txt";
int buffer = 102400;
void setup()
{
  String[] knowledge = loadResources();//2
  String[] spectrumA = initTuring();//4
  String full = "", full2 = "", full3 = "";
  outputx = createWriter("output/prob.txt");
  outputy = createWriter("output/distance.txt");
  outputw = createWriter("output/positions.txt");
  for (int a = 0; a < spectrumA.length-1; a++) {
    int count = 0, distance = 0, position = 0;
    String[] spec = split(spectrumA[a], " ");
    for (int b = 0; b < knowledge.length-2; b++) {
      if (knowledge[b].indexOf(" " + spec[0] + " ") < knowledge[b].indexOf(" " + spec[1] + " ") && knowledge[b].indexOf(" " + spec[0] + " ") > -1 && knowledge[b].indexOf(" " + spec[1] + " ") > -1) {
        count += 1;
        position = b;
        String[] sp = split(knowledge[b], " ");
        int exit = 0;
        for (int x = 0; x < sp.length && exit == 0; x++) {
          for (int x2 = 0; x2 < sp.length && exit == 0; x2++) {
            if (sp[x].equals(spec[0]) == true && sp[x2].equals(spec[1]) == true && x < x2 ) {
              distance = x2-x;
              exit = 1;
            }
          }
        }
        full2 += distance + ",";
        full3 += position + ",";
      }
    }
    full += count + ",";
    full2 += ":";
    full3 += ":";
    if (full.length() >= buffer) {
      outputx.print(full);
      outputx.flush();
      outputy.print(full2);
      outputy.flush();
      outputw.print(full3);
      outputw.flush();
      outputz = createWriter("output/progress.txt");
      outputz.println(a + "/" + spectrumA.length);
      outputz.close();
      full = "";
      full2 = "";
      full3 = "";
    }
  }

  outputx.print(full);
  outputy.print(full2);
  outputw.print(full3);
  outputx.close();
  outputy.close();
  outputw.close();
  exit();
}
String[] loadResources()
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  String[] knowledge = split(str2, ".");
  return knowledge;
}
String[] initTuring() {
  String[] KB = loadStrings("turing.txt");
  String spectrumx = join(KB, "");
  String[] spectrumA = split(spectrumx, ",");
  return spectrumA;
}
