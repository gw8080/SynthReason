PrintWriter outputx;
String resource = "n.txt";
int chunksize = 5;
int num = 100;
int block = 64;
int sens = 100;
int vocabsize = 100;
int searchlength = 10000;
void setup()
{

  String[] knowledge = loadResources();//2
  String[] spectrumFeed = loadResources2(returnstr(knowledge));//3
  String[] spectrumA = initTuring(spectrumFeed);//4
  int[] prob = probability(spectrumA, knowledge);//5
  String spectrum = decide(spectrumA, prob);//6
  String full = returnstr(knowledge);//1
  spectrum = generate(spectrum, full);//7
  outputx = createWriter("output/output.txt");
  outputx.println(spectrum);
  outputx.flush();
  outputx.close();
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
  String[] KB = loadStrings("mind.txt");
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
  while (exit1 == 0) {
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



String generate(String spectrum, String full) {

  String[] eny = split(spectrum, " ");// guide
  String[] enz = split(full, " ");// full
  for (int j = 0; j != eny.length - 1; j++) {
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
  outputx = createWriter("output/7.txt");
  outputx.println(spectrum);
  outputx.close();
  return spectrum;
}
