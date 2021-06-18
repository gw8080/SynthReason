PrintWriter outputx;
PrintWriter status;
String mentalResource = "exp.txt";
String NLP_Resource = "uber.txt";
String vocab = "mixed.txt";// "mixed.txt" or "problem.txt"
String filter = "filter.txt";
int retryLimit = 150; // higher values reduce occurances where there is no output
int mainLoop = 10; // how many attempts to generate a sample
int intermittentLoop = 10; // how many attempts to generate text
int comboSearchValue = 10000; // combo search value
void setup()
{
  outputx = createWriter("output.txt");
  outputx.println("SynthReason output:\n\n" + "Mental resource used: " + mentalResource + "\n" +"NLP resource used: " + NLP_Resource + "\n");
  outputx.flush();
  String[] simulationData = split(eliminateGarbage(mentalResource).toLowerCase(), ".");
  String vocabulary = join(loadStrings(vocab), "\n");
  String[] res = split(eliminateGarbage(NLP_Resource).replace(".", "").toLowerCase(), " ");
  String[] resSegment = split(eliminateGarbage(NLP_Resource).toLowerCase(), ".");
  String resFull = eliminateGarbage(NLP_Resource).toLowerCase();
  String filterControl = join(loadStrings(filter), "\n");
  for (int h3 = 0; h3 < mainLoop; h3++ ) {
    String output = "";
    for (int h2 = 0; h2 < intermittentLoop; h2++ ) {
      int count = 0;
      int x = round(random(simulationData.length-1));
      int NLPconstructionAttempts = split(simulationData[x], " ").length-1;
      for (int f = 0; f < NLPconstructionAttempts*retryLimit; f++) {
        x = round(random(simulationData.length-1));
        NLPconstructionAttempts = split(simulationData[x], " ").length-1;
        String[] alpha = split(simulationData[x], " ");
        if (vocabulary.indexOf("\n" + alpha[round(random(alpha.length-1))] + "\n") > -1) {
          break;
        }
      }
      for (int h = 0; h < NLPconstructionAttempts; count++) {
        String combo = words(split(simulationData[x], " ")[h], res, filterControl);
        if (output.length() == 0 && split(combo, " ").length-1 > 1) {
          output = combo + " ";
          h++;
        }
        if (split(output, " ").length-1 > 1 && split(combo, " ").length-1 > 1) {
          String process = "";
          String[] test = split(output, " ");
          for (int a = test.length-2; a > -1; a--) {
            process += test[a] + " ";
          }
          if (resFull.indexOf(split(process, " ")[0] + " " + split(combo, " ")[2]) > -1 && resFull.indexOf(split(process, " ")[split(process, " ").length-2] + " " + combo) == -1 ) {
            if (controlDivergence(split(process, " ")[0], split(combo, " ")[0], resSegment) == true) {
              output = process + combo + " ";
              h++;
            }
          }
        }
        if (count > retryLimit) {
          h++;
          count = 0;
        }
      }
      status = createWriter("status.txt");
      status.println("SynthReason status");
      status.println("Sample# " + str(h3+1) + "/" + str(mainLoop));
      status.println("Sample progress: " + str(h2+1) + "/" + str(intermittentLoop));
      status.close();
    }
    String output2 = "";
    for (int b = split(output, " ").length/2; b > -1; b-- ) {
      output2 += split(output, " ")[b] + " ";
    }
    outputx.println(output2);
    outputx.println();
    outputx.flush();
  }
  outputx.close();
  exit();
}
String words(String input, String[] res, String filterControl) {
  String state = "";
  for (int x = 0; x < comboSearchValue; x++ ) {
    int rand = round(random(res.length-8))+4;
    if ( res[rand].equals(input) == true) {
      state = res[rand-1] + " " +  res[rand] + " " + res[rand+1];
      if (filterControl.indexOf(res[rand-1]) == -1) {
        break;
      }
    }
  }
  return state;
}
String eliminateGarbage(String resource)
{
  String proc =  join(loadStrings(resource), "");
  String[] eliminate = {"-", "=", "[", "]", ";", ":", ",", "\"", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "(", ")", "\'", "?"};
  for (int k = 0; k < eliminate.length; k++) {
    proc = proc.replace(eliminate[k], "");
  }
  return proc;
}
boolean controlDivergence(String object, String interaction, String[] resource) {
  boolean state = false;
  int objectCount = 0, objectReductionCount = 0;
  for (int j = 0; j < resource.length-1; j++) {
    if (resource[j].indexOf(" " + object + " ") > -1 && resource[j].indexOf(" " + interaction + " ") > -1) {
      objectCount++;
    }
  }
  for (int j = 0; j < resource.length-1; j++) {
    if (resource[j].indexOf(" " + object + " ") > -1 && resource[j].indexOf(" " + interaction + " ") == -1) {
      objectReductionCount++;
    }
  }
  if ( objectCount < objectReductionCount) {
    state = true;
  }
  return state;
}
