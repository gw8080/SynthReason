PrintWriter outputx;
PrintWriter outputz;
String resource = "n.txt";
String mind = "mind.txt";
int block = 64;
int num = 1000;
int sens = 50;
int vocabsize = 200;
int searchlength = 1000;
void setup()
{
  outputz = createWriter("output/output.txt");

  for (int loop = 0; loop < num; loop++) {
    String[] knowledge = loadResources();//2
    String[] spectrumFeed = loadResources2(returnstr(knowledge));//3
    String[] spectrumA = initTuring(spectrumFeed);//4
    int[] prob = probability(spectrumA, knowledge);//5
    String spectrum = decide(spectrumA, prob);//6
    String full = returnstr(knowledge);//1
    String file = "3.txt";
    spectrum = generate(spectrum, full, file, 1);//7
    file = "f.txt";
    spectrum = generate(spectrum, full, file, 0);//7
    outputz.println(spectrum);
    outputz.println();
    outputz.flush();
  }
  outputz.close();
  exit();
}
String returnstr(String[] KB)
{
  String str2 = "";
  for (int i = 0; i != KB.length; i++)
  {
    str2 += KB[i];
  }
  outputx = createWriter("output/1.txt");
  outputx.println(str2);
  outputx.close();
  return str2;
}
String[] loadResources()
{
  String str2 = "";
  String[] KB = loadStrings(resource);
  for (int i = 0; i != KB.length; i++)
  {
    str2 += KB[i];
  }
  String[] knowledge = split(str2, ".");
  outputx = createWriter("output/2.txt");
  outputx.println(str2);
  outputx.close();
  return knowledge;
}
String[] loadResources2(String know)
{
  String str3 = "";
  String[] KB = loadStrings(mind);
  for (int i = 0; i != vocabsize; )
  {
    float r = random(KB.length-1);
    int y = round(r);
    if (know.indexOf(KB[y]) > -1 && str3.indexOf(KB[y]) == -1) {
      str3 += KB[y] + "\n";
      i++;
    }
  }
  String[] spectrumFeed = split(str3, "\n");
  outputx = createWriter("output/3.txt");
  outputx.println(str3);
  outputx.close();
  return spectrumFeed;
}
String[] initTuring(String[] spectrumFeed) {
  String spectrumx = "";
  for (int i = 0; i != spectrumFeed.length-1; i++)
  {
    for (int i2 = 0; i2 != spectrumFeed.length-1; i2++)
    {
      if (spectrumFeed[i] != spectrumFeed[i2]) {
        spectrumx += spectrumFeed[i] + " " + spectrumFeed[i2] + ",";
      }
    }
  }
  String[] spectrumA = split(spectrumx, ",");
  outputx = createWriter("output/4.txt");
  outputx.println(spectrumx);
  outputx.close();
  return spectrumA;
}
int[] probability(String[] spectrumA, String[] knowledge) {
  int[] prob;
  prob = new int[spectrumA.length];
  for (int i = 0; i != spectrumA.length; i++)
  {
    prob[i] = 0;
  }
  for (int a = 0; a < spectrumA.length-1; a++) {
    String[] spec = split(spectrumA[a], " ");
    for (int b = 0; b < knowledge.length-1; b++) {
      if (knowledge[b].indexOf(spec[0]) < knowledge[b].indexOf(spec[1]) && knowledge[b].indexOf(spec[0]) > -1 && knowledge[b].indexOf(spec[1]) > -1) {
        prob[a] += 1;
      }
    }
  }
  String str4 = "";
  for (int x = 0; x != prob.length; x++)
  {
    str4 += prob[x] + ",";
  }
  outputx = createWriter("output/5.txt");
  outputx.println(str4);
  outputx.close();
  return prob;
}
String decide(String[] spectrumA, int[] prob) {
  String spectrumout = "";
  int exit1 = 0;
  int rem = 0;
  for (int count2 = 0; exit1 == 0 && count2 < searchlength; count2++) {
    String dis = "";
    for (int count = 0; count != spectrumA.length-1; count++) {
      String[] spec = split(spectrumA[rem], " ");
      String[] spec2 = split(spectrumA[count], " ");
      if (spec[1].equals(spec2[0]) == true) {
        dis += str(count) + ",";
      }
    }
    int exit = 0;
    for (int e = 0; e < searchlength && exit == 0; e++) {
      String[] disA = split(dis, ","); 
      for (int x = 0; x < disA.length && exit == 0; x++ ) {
        float r = random(sens);
        int y = round(r);
        if (y < prob[int(disA[x])]) {
          spectrumout += spectrumA[int(disA[x])] + " ";
          rem = int(disA[x]);
          if (spectrumout.length() > block) {
            exit1 = 1;
          }
          exit = 1;
        }
      }
    }
  }
  String[] check = split(spectrumout, " ");

  for (int z = 0; z < check.length; z++) {
    spectrumout = spectrumout.replace(check[z] + " " + check[z] + " ", check[z] + " ");
  }
  outputx = createWriter("output/6.txt");
  outputx.println(spectrumout);
  outputx.close();
  return spectrumout;
}
String generate(String spectrum, String full, String file, int mode) {
  String[] KB = loadStrings(file);
  String loop = "";
  for (int i = 0; i != KB.length; i++)
  {
    loop += KB[i] + "\n";
  }
  String[] loopA = split(loop, "\n");
  String[] eny = split(spectrum, " ");// guide
  for (int j = 0; j != eny.length - 1; j++) {
    for (int a = 0; a != loopA.length-1; a++) {
      float r = random(loopA.length-1);
      int x = round(r);
      if (loopA[x] != null ) {
        if (full.indexOf(eny[j] + " " + loopA[x]) > -1 && full.indexOf(loopA[x] + " " + eny[j+1]) > -1 && mode == 0) {
          spectrum = spectrum.replace(eny[j] + " " + eny[j+1] + " ", eny[j] + " " + loopA[x] + " " + eny[j+1] + " ");
          break;
        }
      }
      if (loopA[a] != null ) {
        if (full.indexOf(eny[j] + " " + loopA[a]) > -1 && mode == 1) {
          spectrum = spectrum.replace(eny[j] + " " + eny[j+1] + " ", eny[j] + " " + loopA[a] + " " + eny[j+1] + " ");
          break;
        }
        if (full.indexOf(loopA[a] + " " + eny[j+1]) > -1 && mode == 2) {
          spectrum = spectrum.replace(eny[j] + " " + eny[j+1] + " ", eny[j] + " " + loopA[a] + " " + eny[j+1] + " ");
          break;
        }
      }
    }
  }
  spectrum += ".";
  spectrum = spectrum.replace(" .", ".");
  outputx = createWriter("output/7.txt");
  outputx.println(spectrum);
  outputx.close();
  return spectrum;
}
