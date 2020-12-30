PrintWriter outputx;
PrintWriter outputz;
PrintWriter outputx2;
PrintWriter outputz2;
PrintWriter outputx3;
PrintWriter outputz3;
PrintWriter outputx4;
PrintWriter outputz4;
String mind = "vocab.txt";
int stage = 0;
String[] KB = new String[0];
String str3 = "";
String[] spectrumFeed = new String[0];
void setup()
{
  KB = loadStrings(mind);
  str3 = join(KB, "\n");
  spectrumFeed = split(str3, "\n");
  thread("data1");
  thread("data2");
  thread("data3");
  thread("data4");
}

void data1() {
  int stagebegin = 0;
  int stageend = 1;
  outputx = createWriter("output/turing1.txt");
  for (int i = stagebegin; i < ((spectrumFeed.length-1)/(4))*stageend; i++)
  {
    outputz = createWriter("output/progress1.txt");
    outputz.println(i + "/" + spectrumFeed.length);
    outputz.close();
    String spectrumx = "";
    String[] knowledge = loadResourcesA("text.txt");
    for (int i2 = 0; i2 != spectrumFeed.length-1; i2++)
    {
      for (int x = 0; x < knowledge.length; x++) {
        if (knowledge[x].indexOf(spectrumFeed[i]) < knowledge[x].indexOf(spectrumFeed[i2]) && knowledge[x].indexOf(spectrumFeed[i]) >-1 && knowledge[x].indexOf(spectrumFeed[i2]) >-1) {
          spectrumx += spectrumFeed[i] + " " + spectrumFeed[i2] + ",";
          break;
        }
      }
    }
    outputx.print(spectrumx);
    outputx.flush();
    spectrumx = "";
  }
  outputx.close();
}
void data2() {
  int stagebegin = 1;
  int stageend = 2;
  outputx2 = createWriter("output/turing2.txt");
  for (int i = ((spectrumFeed.length-1)/(4))*stagebegin; i < ((spectrumFeed.length-1)/(4))*stageend; i++)
  {
    outputz2 = createWriter("output/progress2.txt");
    outputz2.println(i + "/" + spectrumFeed.length);
    outputz2.close();
    String spectrumx = "";
    String[] knowledge = loadResourcesA("text.txt");
    for (int i2 = 0; i2 != spectrumFeed.length-1; i2++)
    {
      for (int x = 0; x < knowledge.length; x++) {
        if (knowledge[x].indexOf(spectrumFeed[i]) < knowledge[x].indexOf(spectrumFeed[i2]) && knowledge[x].indexOf(spectrumFeed[i]) >-1 && knowledge[x].indexOf(spectrumFeed[i2]) >-1) {
          spectrumx += spectrumFeed[i] + " " + spectrumFeed[i2] + ",";
          break;
        }
      }
    }
    outputx2.print(spectrumx);
    outputx2.flush();
    spectrumx = "";
  }
  outputx2.close();
}
void data3() {
  int stagebegin = 2;
  int stageend = 3;
  outputx3 = createWriter("output/turing3.txt");
  for (int i = ((spectrumFeed.length-1)/(4))*stagebegin; i < ((spectrumFeed.length-1)/(4))*stageend; i++)
  {
    outputz3 = createWriter("output/progress3.txt");
    outputz3.println(i + "/" + spectrumFeed.length);
    outputz3.close();
    String spectrumx = "";
    String[] knowledge = loadResourcesA("text.txt");
    for (int i2 = 0; i2 != spectrumFeed.length-1; i2++)
    {
      for (int x = 0; x < knowledge.length; x++) {
        if (knowledge[x].indexOf(spectrumFeed[i]) < knowledge[x].indexOf(spectrumFeed[i2]) && knowledge[x].indexOf(spectrumFeed[i]) >-1 && knowledge[x].indexOf(spectrumFeed[i2]) >-1) {
          spectrumx += spectrumFeed[i] + " " + spectrumFeed[i2] + ",";
          break;
        }
      }
    }
    outputx3.print(spectrumx);
    outputx3.flush();
    spectrumx = "";
  }
  outputx3.close();
}
void data4() {
  int stagebegin = 3;
  int stageend = 4;
  outputx4 = createWriter("output/turing4.txt");
  for (int i = ((spectrumFeed.length-1)/(4))*stagebegin; i < ((spectrumFeed.length-1)/(4))*stageend; i++)
  {
    outputz4 = createWriter("output/progress4.txt");
    outputz4.println(i + "/" + spectrumFeed.length);
    outputz4.close();
    String spectrumx = "";
    String[] knowledge = loadResourcesA("text.txt");
    for (int i2 = 0; i2 != spectrumFeed.length-1; i2++)
    {
      for (int x = 0; x < knowledge.length; x++) {
        if (knowledge[x].indexOf(spectrumFeed[i]) < knowledge[x].indexOf(spectrumFeed[i2]) && knowledge[x].indexOf(spectrumFeed[i]) >-1 && knowledge[x].indexOf(spectrumFeed[i2]) >-1) {
          spectrumx += spectrumFeed[i] + " " + spectrumFeed[i2] + ",";
          break;
        }
      }
    }
    outputx4.print(spectrumx);
    outputx4.flush();
    spectrumx = "";
  }
  outputx4.close();
}
String[] loadResourcesA(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  String[] str3 = split(str2, ".");
  return str3;
}
