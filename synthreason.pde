PrintWriter outputx;
PrintWriter status;
String mentalResource = "emotion.txt";
String NLP_Resource = "exp.txt";
String vocab = "mixed.txt";// "mixed.txt" or "problem.txt", "mixed.txt" requires increased values for operational parameters
int retryLimit = 150; // higher values reduce occurances where there is no thought where possible
int mainLoop = 200; // how many attempts to make
int accuracyValue = 20; // the accuracy of generated text
int comboSearchValue = 10000; // combo search value
void setup()
{
  String[] simulationData = split(eliminateGarbage(mentalResource), ".");
  String[] vocabulary = loadStrings(vocab);
  String[] res = split(eliminateGarbage(NLP_Resource).replace(".", ""), " ");
  String resFull = eliminateGarbage(NLP_Resource);
  String output = "";
  for (int h2 = 0; h2 < mainLoop; h2++ ) {
    int count = 0;
    int x = round(random(simulationData.length-1));
    int NLPconstructionAttempts = split(simulationData[x], " ").length-1;
    for (int f = 0; f < NLPconstructionAttempts*retryLimit; f++) {
      x = round(random(simulationData.length-1));
      NLPconstructionAttempts = split(simulationData[x], " ").length-1;
      if (simulationData[x].indexOf(vocabulary[round(random(vocabulary.length-1))]) > -1) {
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
              for (int a = test.length-2; a > 0; a--) {
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
    status.println(str(h2+1) + "/" + str(mainLoop));
    status.close();
  }
  String output2 = "";
  for (int b = split(output, " ").length/2; b > 0; b-- ) {
    output2 += split(output, " ")[b] + " ";
  }
  outputx = createWriter("output.txt");
  outputx.println(output2);
  outputx.close();
  exit();
}
String words(String input, String[] res) {
  String state = "";
  for (int x = 1; x < comboSearchValue; x++ ) {
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
  String[] eliminate2 = {"[", "]", ";", ":", ",", "\"", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "(", ")", "\'", "?"};
  for (int k = 0; k < eliminate2.length; k++) {
    proc = proc.replace(eliminate2[k], "");
  }
  return proc;
}
