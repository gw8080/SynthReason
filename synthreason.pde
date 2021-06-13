PrintWriter outputx;
PrintWriter status;
String mentalResource = "exp.txt";
String NLP_Resource = "uber.txt";
String vocab = "mixed.txt";// "mixed.txt" or "problem.txt"
int retryLimit = 150; // higher values reduce occurances where there is no output
int mainLoop = 5; // how many attempts to generate text
int intermittentLoop = 10; // how many attempts to generate text
int accuracyValue = 20; // the detail accuracy of generated text
int comboSearchValue = 10000; // combo search value
void setup()
{
  outputx = createWriter("output.txt");
  outputx.println("SynthReason output:\n\n" + "Mental resource used: " + mentalResource + "\n" +"NLP resource used: " + NLP_Resource + "\n");
  outputx.flush();
  for (int h3 = 0; h3 < mainLoop; h3++ ) {
    String[] simulationData = split(eliminateGarbage(mentalResource).toLowerCase(), ".");
    String vocabulary = join(loadStrings(vocab), "\n");
    String[] res = split(eliminateGarbage(NLP_Resource).replace(".", "").toLowerCase(), " ");
    String resFull = eliminateGarbage(NLP_Resource).toLowerCase();
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
        String combo = words(split(simulationData[x], " ")[h], res);
        if (output.length() == 0 && split(combo, " ").length-1 > 1) {
          output = combo + " ";
          h++;
        }
        if (split(output, " ").length-1 > 1 && split(combo, " ").length-1 > 1) {
          if (resFull.indexOf(split(combo, " ")[1]) > -1) {
            int contextCount = 0;
            for (int y = 0; y < accuracyValue; y++) {
              if (resFull.indexOf(split(output, " ")[round(random(split(output, " ").length-1))]) > -1) {
                contextCount++;
              }
              if (contextCount == accuracyValue) {
                String process = "";
                String[] test = split(output, " ");
                for (int a = test.length-2; a > -1; a--) {
                  process += test[a] + " ";
                }
                if (resFull.indexOf(split(process, " ")[split(process, " ").length-2] + " " + split(combo, " ")[0]) > -1 && resFull.indexOf(split(process, " ")[split(process, " ").length-2] + " " + combo) == -1 ) {
                  output = process + combo + " ";
                  h++;
                }
              }
            }
          }
        }
        if (count > retryLimit*NLPconstructionAttempts) {
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
    String output2 = "[prompt]\n";
    for (int b = split(output, " ").length/2; b > -1; b-- ) {
      output2 += split(output, " ")[b] + " ";
    }
    output2 += ".\n\n[response]\n";
    for (int b = split(output, " ").length/2; b < split(output, " ").length-1; b++ ) {
      output2 += split(output, " ")[b] + " ";
    }
    output2 += ".";
    outputx.println(output2);
    outputx.println();
    outputx.flush();
  }
  outputx.close();
  exit();
}
String words(String input, String[] res) {
  String state = "";
  for (int x = 0; x < comboSearchValue; x++ ) {
    int rand = round(random(res.length-4))+2;
    if ( res[rand].equals(input) == true) {
      state = res[rand-1] + " " +  res[rand] + " " + res[rand+1];
      if (res[rand-1].length() > 3) {
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
